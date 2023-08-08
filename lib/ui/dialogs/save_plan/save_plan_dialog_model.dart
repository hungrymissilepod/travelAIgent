import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class SavePlanDialogModel extends BaseViewModel {
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final Logger _logger = getLogger('SavePlanDialogModel');

  final TextEditingController nameController = TextEditingController();

  late final Plan _plan;

  SavePlanDialogModel(Plan plan) {
    _plan = plan;
    nameController.text = 'My ${_plan.city} trip';
  }

  Future<void> onSaveTap() async {
    _logSavePlanEvent();
    _logger.i('plan name: ${nameController.text}');
    _plan.name = nameController.text;

    if (await runBusyFuture(_firestoreService.addPlan(_plan))) {
      _whoAmIService.addPlan(_plan);
      _navigationService.clearStackAndShow(Routes.dashboardView);
    }
  }

  void onCancelTap() {
    _navigationService.back();
  }

  void _logSavePlanEvent() {
    int? numDays;
    if (_plan.destination != null) {
      numDays = _plan.destination!.toDate.difference(_plan.destination!.fromDate).inDays;
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
