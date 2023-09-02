import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:in_app_review/in_app_review.dart';

class DashboardViewModel extends BaseViewModel {
  final InAppReview _inAppReview = InAppReview.instance;
  final PageController pageController = PageController(initialPage: 0);
  int selectedPage = 0;

  DashboardViewModel({bool userJustSavedPlan = false}) {
    _pronptForReview(userJustSavedPlan);
  }

  Future<void> _pronptForReview(bool userJustSavedPlan) async {
    /// Only ask user to review the app if they have just saved a plan
    if (userJustSavedPlan) {
      if (await _inAppReview.isAvailable()) {
        /// Add slight delay so that ad and this prompt hopefully
        /// do not show at same time (hacky solution)
        await Future.delayed(const Duration(seconds: 5));
        _inAppReview.requestReview();
      }
    }
  }

  void onPageChanged(int index) {
    selectedPage = index;
    rebuildUi();
  }

  /// Animate from one page to the next, unless that page is more than
  /// one page away
  void onBottomNavBarTapped(int value) {
    if ((selectedPage - value).abs() > 1) {
      _jumpToPage(value);
    } else {
      _animateToPage(value);
    }
  }

  void _animateToPage(int value) {
    selectedPage = value;
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
    rebuildUi();
  }

  void _jumpToPage(int value) {
    selectedPage = value;
    pageController.jumpToPage(value);
    rebuildUi();
  }

  void navigateToHomeView() {
    onBottomNavBarTapped(0);
  }
}
