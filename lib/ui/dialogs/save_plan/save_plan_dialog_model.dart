import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/admob_service.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class SavePlanDialogModel extends BaseViewModel {
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final AdmobService _admobService = locator<AdmobService>();
  final Logger _logger = getLogger('SavePlanDialogModel');

  final TextEditingController nameController = TextEditingController();

  late final Plan _plan;

  bool planSaved = false;

  SavePlanDialogModel(Plan plan) {
    _plan = plan;
    nameController.text = 'My ${_plan.city} trip';

    /// TODO: Add some logic here to check number of plans user has saved.
    /// Either only show after they have saved a plan before. Or can randomise if they see an ad first time or not
    _admobService.loadAfterSavePlanInterstitialAd();
  }

  void _showInterstitialAd() async {
    await _admobService.afterSavePlanInterstitialAd?.show();
    _admobService.afterSavePlanInterstitialAd?.dispose();
  }

  Future<void> onSaveTap() async {
    _logSavePlanEvent();
    _logger.i('plan name: ${nameController.text}');
    _plan.name = nameController.text;

    if (await runBusyFuture(_firestoreService.addPlan(_plan))) {
      HapticFeedback.lightImpact();
      _whoAmIService.addPlan(_plan);
      planSaved = true;
      rebuildUi();
    }
  }

  void onCancelTap() {
    _navigationService.back();
  }

  void onDoneTap() async {
    _showInterstitialAd();
    await _navigationService.clearStackAndShow(
      Routes.dashboardView,
      arguments: const DashboardViewArguments(userJustSavedPlan: true),
    );
  }

  void _logSavePlanEvent() {
    int? numDays;
    if (_plan.destination != null) {
      numDays = _plan.destination!.toDate
          .difference(_plan.destination!.fromDate)
          .inDays;
    }
    _analyticsService.logEvent(
      'SavePlan',
      parameters: {
        'from': _plan.destination?.from,
        'to': _plan.destination?.to,
        'numDays': numDays,
        'numTravellers': _plan.destination?.travellers,
        'holidayType': _plan.preferences?.holidayType,
        'interests': _plan.preferences?.holidayType,
        'city': _plan.city,
        'country': _plan.country,
      },
    );
  }
}
