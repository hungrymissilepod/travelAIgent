// import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:travel_aigent/ui/views/home/ui/flexible_destinations/flexible_destination_model.dart';

enum HomeViewSection { fromTextField, toTextField }

class HomeViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final AirportService _airportService = locator<AirportService>();
  final Logger _logger = getLogger('HomeViewModel');

  final DestinationValidator _destinationValidator = DestinationValidator();

  final FocusNode whereFromFocusNode = FocusNode();
  final TextEditingController whereFromController = TextEditingController();

  final FocusNode whereToFocusNode = FocusNode();
  final TextEditingController whereToController = TextEditingController()..text = anywhere;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 7));

  int _travellers = 1;
  int get travellers => _travellers;

  AirportData get airportData => _airportService.airportData;

  String get whereFromDefaultValue => _airportService.defaultFromValue;

  HomeViewModel() {
    _clearTextFieldOnTap(whereFromFocusNode, whereFromController, HomeViewSection.fromTextField);
    _clearTextFieldOnTap(whereToFocusNode, whereToController, HomeViewSection.toTextField);

    whereFromController.text = _airportService.defaultFromValue;
    rebuildUi();
  }

  void _clearTextFieldOnTap(FocusNode focusNode, TextEditingController controller, Object object) {
    /// Clear text field value when tapping on it
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {
        controller.clear();
        rebuildUi();
      }
    });

    /// Clear any errors once the user starts typing in this text field
    controller.addListener(() {
      if (error(object) == true) {
        setErrorForObject(object, false);
      }
    });
  }

  void setToTextField(String value) {
    whereToController.text = value;
    rebuildUi();
  }

  bool fromTextFieldHasError() {
    return error(HomeViewSection.fromTextField) == true;
  }

  bool fromToFieldHasError() {
    return error(HomeViewSection.toTextField) == true;
  }

  void incrementTravellers() {
    if (_travellers < 9) {
      _travellers++;
      rebuildUi();
    }
  }

  void decrementTravellers() {
    if (_travellers > 1) {
      _travellers--;
      rebuildUi();
    }
  }

  void updateDates(DateTime? from, DateTime? to) {
    _logger.i('from: ${from?.datePickerFormat()} - to: ${to?.datePickerFormat()}');
    fromDate = from ?? fromDate;
    toDate = to ?? toDate;
    rebuildUi();
  }

  void onGenerateTapped() {
    clearErrors();

    /// Check that this text field has a value and that it is valid
    if (whereFromController.text.isEmpty ||
        !_destinationValidator.isValidSuggestion(airportData, whereFromController.text)) {
      setErrorForObject(HomeViewSection.fromTextField, true);
    }

    if (whereToController.text.isEmpty ||
        !_destinationValidator.isValidSuggestion(airportData, whereToController.text)) {
      setErrorForObject(HomeViewSection.toTextField, true);
    }

    if (error(HomeViewSection.fromTextField) == true || error(HomeViewSection.toTextField) == true) {
      return;
    }

    _generatorService
        .setDestination(Destination(whereFromController.text, whereToController.text, fromDate, toDate, travellers));
    _navigationService.navigateToPreferencesView();
  }

  void onAvatarTap() {
    if (_firebaseUserService.isFullUser()) {
      _navigationService.navigateToProfileView();
    } else {
      _navigationService.navigateToRegisterView();
    }
  }

  bool isUserLoggedIn() => _firebaseUserService.isFullUser();

  String get welcomeMessage {
    if (isUserLoggedIn()) {
      return 'Hi ${_whoAmIService.whoAmI.name}!';
    }
    return 'Hi!';
  }

  /// TODO: temporary. Need to find somewhere to put this button
  void onSignInTap() {
    _navigationService.navigateToSignInView();
  }
}

class DestinationValidator {
  bool isValidSuggestion(AirportData data, String text) {
    final isValidFlexibleDestination = _isValidFlexibleDestination(data, text);
    if (isValidFlexibleDestination) return true;

    final isValidCountry = _isValidCountry(data, text);
    if (isValidCountry) return true;

    final isValidCity = _isValidCity(data, text);
    if (isValidCity) return true;

    final isValidAirport = _isValidAirport(data, text);
    if (isValidAirport) return true;

    return false;
  }

  bool _isValidCountry(AirportData data, String text) {
    for (Country c in data.countries) {
      if (c.country == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidCity(AirportData data, String text) {
    for (City c in data.cities) {
      if (c.city == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidAirport(AirportData data, String text) {
    for (Airport c in data.airports) {
      if (c.airportName == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidFlexibleDestination(AirportData data, String text) {
    for (FlexibleDestination c in data.flexibleDestinations) {
      if (c.name == text) {
        return true;
      }
    }
    return false;
  }
}
