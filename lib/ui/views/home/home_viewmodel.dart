import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:travel_aigent/ui/views/home/destination_validator.dart';

enum HomeViewSection { fromTextField, toTextField }

class HomeViewModel extends ReactiveViewModel {
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final AirportService _airportService = locator<AirportService>();
  final HiveService _hiveService = locator<HiveService>();
  final Logger _logger = getLogger('HomeViewModel');

  @override
  List<ListenableServiceMixin> get listenableServices => [_whoAmIService];

  bool destinationValidationDisabled = false;

  final DestinationValidator _destinationValidator = DestinationValidator();

  final FocusNode whereFromFocusNode = FocusNode();
  final TextEditingController whereFromController = TextEditingController();

  final FocusNode whereToFocusNode = FocusNode();
  final TextEditingController whereToController = TextEditingController()
    ..text = anywhere;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 7));

  int _travellers = 1;
  int get travellers => _travellers;

  bool travellersMinusButtonEnabled = false;
  bool travellersPlusButtonEnabled = true;

  AirportData get airportData => _airportService.airportData;

  String get whereFromDefaultValue => _airportService.defaultFromValue;

  HomeViewModel() {
    init();
  }

  Future<void> init() async {
    _clearTextFieldOnTap(
        whereFromFocusNode, whereFromController, HomeViewSection.fromTextField);
    _clearTextFieldOnTap(
        whereToFocusNode, whereToController, HomeViewSection.toTextField);

    whereFromController.text = _airportService.defaultFromValue;

    /// Jake - Should probably add this validation back at some point
    destinationValidationDisabled =
        await _hiveService.read(HiveKeys.destinationValidationDisabled) ?? true;
    rebuildUi();
  }

  void _clearTextFieldOnTap(
      FocusNode focusNode, TextEditingController controller, Object object) {
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
    /// Clear the text field if user selects the same flexible destination again
    if (whereToController.text == value) {
      whereToController.clear();
    } else {
      whereToController.text = value;
    }

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

      _updateTravellersButtons();
      rebuildUi();
    }
  }

  void decrementTravellers() {
    if (_travellers > 1) {
      _travellers--;
      _updateTravellersButtons();
      rebuildUi();
    }
  }

  void _updateTravellersButtons() {
    if (_travellers >= 9) {
      travellersPlusButtonEnabled = false;
    } else {
      travellersPlusButtonEnabled = true;
    }

    if (_travellers <= 1) {
      travellersMinusButtonEnabled = false;
    } else {
      travellersMinusButtonEnabled = true;
    }
  }

  void updateDates(DateTime? from, DateTime? to) {
    _logger
        .i('from: ${from?.datePickerFormat()} - to: ${to?.datePickerFormat()}');
    fromDate = from ?? fromDate;
    toDate = to ?? toDate;
    rebuildUi();
  }

  void onGenerateTapped() {
    clearErrors();

    /// Check that this text field is not empty
    if (whereFromController.text.isEmpty) {
      setErrorForObject(HomeViewSection.fromTextField, true);
    }

    /// Check that this text field has a valid suggestion
    /// We do not do this if [destinationValidationDisabled] cheat is turned on ;)
    if (!destinationValidationDisabled) {
      if (!_destinationValidator.isValidSuggestion(
          airportData, whereFromController.text)) {
        setErrorForObject(HomeViewSection.fromTextField, true);
      }
    }

    if (whereToController.text.isEmpty) {
      setErrorForObject(HomeViewSection.toTextField, true);
    }

    if (!destinationValidationDisabled) {
      if (!_destinationValidator.isValidSuggestion(
          airportData, whereToController.text)) {
        setErrorForObject(HomeViewSection.toTextField, true);
      }
    }

    if (error(HomeViewSection.fromTextField) == true ||
        error(HomeViewSection.toTextField) == true) {
      return;
    }

    _generatorService.setDestination(Destination(whereFromController.text,
        whereToController.text, fromDate, toDate, travellers));
    _navigationService.navigateToPreferencesView();
  }

  bool isUserLoggedIn() => _firebaseUserService.isFullUser();

  String get welcomeMessage {
    if (isUserLoggedIn()) {
      return 'Hey ${_whoAmIService.whoAmI.firstName()}!';
    }
    return 'Hey amigo!';
  }

  void onProfileIconTapped() {
    _navigationService.navigateToProfileView();
  }
}
