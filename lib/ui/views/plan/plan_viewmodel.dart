import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';

class PlanViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PlanViewModel');

  late Plan? plan;

  Destination? get destination => plan?.destination;
  Preferences? get preferences => plan?.preferences;

  Future<void> generatePlan(Plan? savedPlan) async {
    clearErrors();

    /// If we are displaying a saved plan, do not generate anything
    if (savedPlan != null) {
      plan = savedPlan;
      return;
    }
    setBusy(true);
    plan = await _generatorService.generatePlan();
    setBusy(false);
    if (plan == null) {
      setError(true);
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

  void onSaveTripTap() {
    if (!_firebaseUserService.isFullUser()) {
      _analyticsService.logEvent('ShowPrompRegisterDialog');
      _dialogService.showCustomDialog(
        variant: DialogType.promptRegister,
        barrierDismissible: true,
      );
      return;
    }

    _analyticsService.logEvent('ShowSavePlanDialog');
    _dialogService.showCustomDialog(
      variant: DialogType.savePlan,
      barrierDismissible: true,
      data: plan,
    );
  }
}
