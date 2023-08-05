import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class SavePlanDialogModel extends BaseViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
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
    _logger.i('plan name: ${nameController.text}');
    _plan.name = nameController.text;

    if (!_authenticationService.userLoggedIn()) {
      _logger.i('prompt user to create account');
      return;
    }

    if (await runBusyFuture(_firestoreService.addPlan(_plan))) {
      _whoAmIService.addPlan(_plan);
      _navigationService.clearStackAndShow(Routes.dashboardView);
    }
  }

  void onCancelTap() {
    _navigationService.back();
  }
}
