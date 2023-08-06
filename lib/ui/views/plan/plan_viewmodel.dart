import 'package:intl/intl.dart';
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
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/generator_service.dart';

class PlanViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PlanViewModel');

  bool isSavedPlan = false;
  Plan? plan;

  Destination get destination => _generatorService.destination;
  Preferences get preferences => _generatorService.preferences;

  /// TODO: add ability to change to farenheit
  final String celciusChar = '°C';

  Future<void> generatePlan(Plan? savedPlan) async {
    /// If we are displaying a saved plan, do not generate anything
    if (savedPlan != null) {
      plan = savedPlan;
      isSavedPlan = true;
      return;
    }
    plan = await runBusyFuture(_generatorService.generatePlan());
  }

  String getTravellerString() {
    if (destination.travellers == 1) {
      return 'traveller';
    }
    return 'travellers';
  }

  String getDistanceString() {
    if (plan?.distance == 1) {
      return 'hour away';
    }
    return 'hours away';
  }

  /// Compares the [fromDate] and [toDate] months and returns a String
  /// used in displaying average temperature
  String getTemperatureString() {
    String fromMonth = DateFormat('MMM').format(destination.fromDate);
    String toMonth = DateFormat('MMM').format(destination.toDate);
    if (fromMonth == toMonth) {
      return '$celciusChar in $fromMonth';
    }
    return '$celciusChar in $fromMonth - $toMonth';
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
    if (!_authenticationService.userLoggedIn()) {
      _dialogService.showCustomDialog(
        variant: DialogType.promptRegister,
        barrierDismissible: true,
      );
      return;
    }

    _dialogService.showCustomDialog(
      variant: DialogType.savePlan,
      barrierDismissible: true,
      data: plan,
    );
  }
}
