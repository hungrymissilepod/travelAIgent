import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/generator_service.dart';

const double totalSteps = 3;

class PreferencesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final Logger _logger = getLogger('PreferencesViewModel');

  final PageController pageController = PageController();
  int currentPage = 0;

  double percent = 0.0;

  /// The difference between each percent step
  final double _percentStep = 1.0 / totalSteps;

  String _holidayType = '';

  final List<String> _interests = <String>[];

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
        _navigationService.replaceWithCounterView();
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

    if (page == 1) {
      _setPreferences();
    }
  }

  /// Pass [PreferencesModel] to [GeneratorService]
  void _setPreferences() {
    _generatorService.setPreferences(PreferencesModel(_holidayType, _interests));
  }
}
