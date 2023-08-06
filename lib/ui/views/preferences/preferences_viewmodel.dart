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

enum PreferencesViewError { holidayType, interestsView }

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

  // final List<String> _interests = <String>[];
  final Set<String> _interests = <String>{};

  bool ctaButtonEnabled = false;

  void init() {
    percent = _percentStep;
    rebuildUi();
  }

  void onContinueTap() {
    clearErrors();

    /// If on [HolidayTypeView]
    if (currentPage == 0) {
      if (_holidayType.isEmpty) {
        print('please select a holiday type');
      } else {
        _incrementPage();
      }
    }

    /// If on [InterestsView]
    else if (currentPage == 1) {
      /// TODO: validate that at least one chip is selected
      if (_interests.isEmpty) {
        print('please select some interests');
      } else {
        _incrementPage();
      }
    }
  }

  String getAppBarTitle() {
    if (currentPage == 0) {
      return 'Select holiday type';
    }
    return 'Select your interests';
  }

  String getCTAButtonLabel() {
    if (currentPage == 0) {
      return 'Select your interests';
    }
    return 'Generate trip';
  }

  void _incrementPage() {
    if (currentPage < totalSteps - 1) {
      currentPage++;
      _incrementPercent();
      if (currentPage == totalSteps - 1) {
        _navigationService.replaceWithPlanView();
      } else {
        ctaButtonEnabled = _updateCTAButtonEnabled();
        rebuildUi();
        _animateToPage(currentPage);
      }
    }
  }

  void onAppBarBackTap() {
    if (currentPage == 0) {
      _holidayType = '';
      _interests.clear();
      _navigationService.back();
    }

    if (currentPage > 0) {
      _interests.clear();
      currentPage--;
      _animateToPage(currentPage);
      _decrementPercent();
    }
  }

  void setHolidayType(String value) {
    _holidayType = value;
    _logger.i('holidayType: $_holidayType');
    ctaButtonEnabled = _updateCTAButtonEnabled();
    rebuildUi();
  }

  bool isHolidayTypeSelected(String value) {
    return _holidayType == value;
  }

  bool isInterestSelected(String value) {
    return _interests.contains(value);
  }

  void addInterest(String value) {
    if (_interests.contains(value)) {
      _interests.remove(value);
    } else {
      if (_interests.length < 5) {
        _interests.add(value);
      }
    }

    _logger.i('_interests: ${_interests.toString()}');
    ctaButtonEnabled = _updateCTAButtonEnabled();
    rebuildUi();
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

  /// Pass [Preferences] to [GeneratorService]
  void _setPreferences() {
    _generatorService.setPreferences(Preferences(_holidayType, _interests));
  }

  bool _updateCTAButtonEnabled() {
    if (currentPage == 0) {
      return _holidayType.isNotEmpty;
    } else if (currentPage == 1) {
      return _interests.isNotEmpty;
    }
    return false;
  }

  String getHolidayTypePromptCount() {
    if (_holidayType.isEmpty) {
      return '(Selected 0 of 1)';
    }
    return '(Selected 1 of 1)';
  }

  String getInterestTypePromptCount() {
    return '(Selected ${_interests.length} of 5)';
  }
}
