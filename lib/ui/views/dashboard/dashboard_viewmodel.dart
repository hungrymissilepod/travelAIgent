import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  final PageController pageController = PageController(initialPage: 0);
  int selectedPage = 0;

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
