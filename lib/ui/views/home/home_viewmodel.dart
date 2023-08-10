import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/services/ip_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final IpService _ipService = locator<IpService>();
  final Logger _logger = getLogger('HomeViewModel');

  final FocusNode whereFromFocusNode = FocusNode();
  final TextEditingController whereFromController =
      TextEditingController(text: 'initial');

  final FocusNode whereToFocusNode = FocusNode();
  final TextEditingController whereToController = TextEditingController()
    ..text = 'Anywhere';

  List<String> _countriesList = <String>[];
  List<String> get countriesList => _countriesList;

  List<String> _whereToCountriesList = <String>[];
  List<String> get whereToCountriesList => _whereToCountriesList;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(days: 7));

  List<String> interests = <String>[];
  List<String> holidayTypes = <String>[];

  int _travellers = 1;
  int get travellers => _travellers;

  HomeViewModel() {
    /// Generate this list of country names once on init
    _generateCountriesList();
    _clearTextFieldOnTap(whereFromFocusNode, whereFromController);
    _clearTextFieldOnTap(whereToFocusNode, whereToController);

    /// Set default value to user's location
    whereFromController.text = _ipService.ipLocation?.country ?? '';
  }

  void _clearTextFieldOnTap(
      FocusNode focusNode, TextEditingController controller) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.clear();
        rebuildUi();
      }
    });
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

  /// Sort all countries in alphabetic order
  void _generateCountriesList() {
    final List<Country> countriesCopy = List<Country>.from(countries);
    countriesCopy.sort((a, b) => a.name.compareTo(b.name));
    _countriesList = countriesCopy.map((e) => e.name).toList();

    /// Add Anywhere as an option for the whereTo field
    _whereToCountriesList = ['Anywhere', ..._countriesList];
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
    _logger
        .i('from: ${from?.datePickerFormat()} - to: ${to?.datePickerFormat()}');
    fromDate = from ?? fromDate;
    toDate = to ?? toDate;
    rebuildUi();
  }

  void onGenerateTapped() {
    /// TODO: add validation and check it here before navigating
    _generatorService.setDestination(Destination(whereFromController.text,
        whereToController.text, fromDate, toDate, travellers));
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
