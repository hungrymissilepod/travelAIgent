import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class PlanViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  final ScrollController scrollController = ScrollController();

  late Plan? plan;

  bool showSaveButton = true;

  Destination? get destination => plan?.destination;
  Preferences? get preferences => plan?.preferences;

  String? get _displayName => _whoAmIService.whoAmI.firstName();

  String title() {
    if (_displayName!.isEmpty || _displayName == null) {
      return 'You\'ll love ${plan?.city ?? ''}';
    }
    return '$_displayName, you\'ll love ${plan?.city ?? ''}';
  }

  Future<void> generatePlan(Plan? savedPlan) async {
    clearErrors();

    /// If we are displaying a saved plan, do not generate anything
    if (savedPlan != null) {
      plan = savedPlan;
      return;
    }

    /// Generate plan from AI
    plan = await runBusyFuture(_generatorService.generatePlan());

    /// Now fetch images for the plan
    if (plan != null) {
      plan = await runBusyFuture(_generatorService.fetchImages(plan!));
    }
  }

  void onTryAgainButtonTap() {
    _generatorService.addToBlacklistedCities(plan?.city ?? '');
    _navigationService.clearStackAndShow(Routes.planView);
  }

  void onContinueButtonTap() {
    _navigationService.back();
  }

  void onExitButtonTap() {
    _generatorService.clearBlackList();
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }

  void onSaveTripTap() async {
    if (!_firebaseUserService.isFullUser()) {
      _analyticsService.logEvent('ShowPrompRegisterDialog');
      final DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.promptRegister,
        barrierDismissible: true,
      );
      if (response != null) {
        if (response.confirmed) {
          _showSavePlanDialog();
        }
      }

      return;
    }

    _showSavePlanDialog();
  }

  void _showSavePlanDialog() async {
    _analyticsService.logEvent('ShowSavePlanDialog');
    await _dialogService.showCustomDialog(
      variant: DialogType.savePlan,
      barrierDismissible: true,
      data: plan,
    );

    /// This is an edge case where the user saves a plan and then taps outside
    /// of the dialog to close it.
    /// We check the user's saved plans in the [whoAmI] to see if they have a plan with the
    /// same [id].
    /// This means that the user must have just saved this plan.
    /// Therefore we hide the save [CTAButton].
    /// Another way to handle this would be to set [barrierDismissible] to [false] but
    /// I believe that is bad UX.

    if (_whoAmIService.whoAmI.plans.where((e) => e.id == plan?.id).isNotEmpty) {
      /// If user just saved this plan, hide this button so they cannot save it again
      showSaveButton = false;
      rebuildUi();
    }
  }
}
