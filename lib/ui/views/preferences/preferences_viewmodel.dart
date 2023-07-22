import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/ui/views/preferences/preferences_view.dart';

const double totalSteps = 3;

class PreferencesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PreferencesViewModel');

  final PageController pageController = PageController();
  int currentPage = 0;

  double percent = 0.0;

  /// The difference between each percent step
  final double _percentStep = 1.0 / totalSteps;

  String _holidayType = '';

  final List<ChipModel> holidayTypeChips = <ChipModel>[
    ChipModel('Beach', '🏖️'),
    ChipModel('City', '🏢'),
    ChipModel('Adventure', '🥾'),
    ChipModel('Family', '👨‍👩‍👧‍👦'),
    ChipModel('Safari', '🦁'),
    ChipModel('Skiing', '🎿'),
    ChipModel('Cruise', '🛳️'),
    ChipModel('Theme parks', '🎡'),
    ChipModel('Camping', '🏕️'),
  ];

  final List<String> _interests = <String>[];

  final List<ChipModel> interestChips = <ChipModel>[
    ChipModel('Food', '😋'),
    ChipModel('Drinks', '🍻'),
    ChipModel('Nightclubs', '🕺'),
    ChipModel('Museums', '🏛️'),
    ChipModel('Art galleries', '🖼️'),
    ChipModel('Shopping', '🛍️'),
    ChipModel('History', '📜'),
    ChipModel('Concerts', '🎫'),
    ChipModel('Architecture', '🏗️'),
    ChipModel('Comedy', '🎙️'),
  ];

  void init() {
    percent = _percentStep;
    rebuildUi();
  }

  void onContinueTap() {
    if (currentPage < totalSteps - 1) {
      currentPage++;
      _incrementPercent();
      if (currentPage == totalSteps - 1) {
        /// TODO: navigate to loading screen and actually generate everything
        _navigationService.navigateToCounterView();
      } else {
        _animateToPage(currentPage);
      }
    }
  }

  void onAppBarBackTap() {
    if (currentPage == 0) {
      _navigationService.back();
    }

    if (currentPage > 0) {
      currentPage--;
      _animateToPage(currentPage);
      _decrementPercent();
    }
  }

  void setHolidayType(String value) {
    _holidayType = value;
    _logger.i('holidayType: $_holidayType');
  }

  void addInterest(String value) {
    _interests.add(value);
    _logger.i('_interests: ${_interests.toString()}');
  }

  void _incrementPercent() {
    percent = (percent += _percentStep).clamp(0.0, 1.0);
    rebuildUi();
  }

  void _decrementPercent() {
    percent = (percent -= _percentStep).clamp(0.0, 1.0);
    rebuildUi();
  }

  void _animateToPage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }
}
