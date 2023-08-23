import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends BaseViewModel {
  final PageController pageController = PageController(initialPage: 0);
  int selectedPage = 0;

  void onBottomNavBarTapped(int value) {
    selectedPage = value;
    pageController.animateToPage(selectedPage,
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
    rebuildUi();
  }

  void navigateToHomeView() {
    onBottomNavBarTapped(0);
  }
}
