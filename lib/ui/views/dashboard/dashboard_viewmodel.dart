import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/services/hive_service.dart';

class DashboardViewModel extends BaseViewModel {
  final HiveService _hiveService = locator<HiveService>();
  final InAppReview _inAppReview = InAppReview.instance;
  final PageController pageController = PageController(initialPage: 0);

  int numDaysBetweenReviewPrompt = 1;
  int selectedPage = 0;

  DashboardViewModel({bool userJustSavedPlan = false}) {
    _promptForReview(userJustSavedPlan);
  }

  Future<void> _promptForReview(bool userJustSavedPlan) async {
    if (!await _canPromptForReview()) return;

    /// Only ask user to review the app if they have just saved a plan
    if (userJustSavedPlan) {
      if (await _inAppReview.isAvailable()) {
        /// Add slight delay so that ad and this prompt hopefully
        /// do not show at same time (hacky solution)
        await Future.delayed(const Duration(seconds: 5));
        _inAppReview.requestReview();
        _hiveService.write(HiveKeys.daysSinceLastPromptedForReview,
            DateTime.now().millisecondsSinceEpoch);
      }
    }
  }

  /// Checks the last time we prompted the user for review
  /// to ensure we do not spam them with requests
  Future<bool> _canPromptForReview() async {
    final int lastTimePromptMilliseconds = await _hiveService
        .read(HiveKeys.daysSinceLastPromptedForReview, defaultValue: 0);

    /// If [lastTimePromptMilliseconds] is 0 it means we have not asked for review before
    /// Or if the last time we asked for a review was more than [numDaysBetweenReviewPrompt] days ago,
    /// we can ask the user for review
    if (lastTimePromptMilliseconds == 0 ||
        DateTime.fromMillisecondsSinceEpoch(lastTimePromptMilliseconds)
                .difference(DateTime.now())
                .inDays >=
            numDaysBetweenReviewPrompt) {
      return true;
    }
    return false;
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
