// import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final AirportService _airportService = locator<AirportService>();
  final Logger _logger = getLogger('HomeViewModel');

  final FocusNode whereFromFocusNode = FocusNode();
  final TextEditingController whereFromController = TextEditingController(text: 'initial');

  final FocusNode whereToFocusNode = FocusNode();

  /// TODO: add Anywhere toggle and make it enabled by default. This will promot the user to understand what the toggle does
  /// We could also add the Anywhere option to the suggestion list (only for To? field). Could show an icon of the Earth to show that the user will go anywhere
  final TextEditingController whereToController = TextEditingController()..text = anywhere;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 7));

  List<String> interests = <String>[];
  List<String> holidayTypes = <String>[];

  int _travellers = 1;
  int get travellers => _travellers;

  /// TODO: add the Anywhere toggle
  AirportData get airportData => _airportService.airportData;

  String get whereFromDefaultValue => _airportService.defaultFromValue;

  HomeViewModel() {
    _clearTextFieldOnTap(whereFromFocusNode, whereFromController);
    _clearTextFieldOnTap(whereToFocusNode, whereToController);

    whereFromController.text = _airportService.defaultFromValue;
    rebuildUi();
  }

  @Deprecated('No longer in use but may be handy for futuure')
  void _clearTextFieldAndHighlightContentsOnTap(FocusNode focusNode, TextEditingController controller) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.value = TextEditingValue(
            text: controller.text, selection: TextSelection(baseOffset: 0, extentOffset: controller.text.length));
        rebuildUi();
      }
    });
  }

  void _clearTextFieldOnTap(FocusNode focusNode, TextEditingController controller) {
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {
        controller.clear();
        rebuildUi();
      }
    });
  }

  void setToTextField(String value) {
    whereToController.text = value;
    rebuildUi();
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

  void updateInterests(String value) {
    interests = value.split(',');
    rebuildUi();
  }

  void updateHolidayTypes(String value) {
    holidayTypes = value.split(',');
    rebuildUi();
  }

  void updateDates(DateTime? from, DateTime? to) {
    _logger.i('from: ${from?.datePickerFormat()} - to: ${to?.datePickerFormat()}');
    fromDate = from ?? fromDate;
    toDate = to ?? toDate;
    rebuildUi();
  }

  void onGenerateTapped() {
    /// TODO: add validation and check it here before navigating
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
