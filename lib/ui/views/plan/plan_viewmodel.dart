import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/ip_location_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/services/ip_service.dart';

class PlanViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final IpService _ipService = locator<IpService>();
  final Logger _logger = getLogger('PlanViewModel');

  Plan? get plan => generatedPlan?.plan;

  GeneratedPlan? generatedPlan;

  Destination get destination => _generatorService.destination;
  Preferences get preferences => _generatorService.preferences;

  IpLocation? get ipLocation => _ipService.ipLocation;

  double? calculateExchangeInverse() {
    double? exchangeRate = generatedPlan?.exchangeRateData?.exchangeRate;
    if (exchangeRate == null) return null;
    double? r = 1.0 / exchangeRate;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }

  double? calculateBeerPrice() {
    double? beerPrice = generatedPlan?.exchangeRateData?.beerPrice;
    if (beerPrice == null) return null;
    double? r = beerPrice * generatedPlan!.exchangeRateData!.exchangeRate!;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }

  /// TODO: add ability to change to farenheit
  final String celciusChar = '°C';

  Future<void> generatePlan(Plan? savedPlan) async {
    clearErrors();

    /// If we are displaying a saved plan, do not generate anything
    if (savedPlan != null) {
      generatedPlan?.plan = savedPlan;
      return;
    }
    generatedPlan = await runBusyFuture(_generatorService.generatePlan());
  }

  String getTravellerString() {
    if (destination.travellers == 1) {
      return 'traveller';
    }
    return 'travellers';
  }

  String getDistanceString() {
    if (generatedPlan?.plan.distance == 1) {
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
    _generatorService.addToBlacklistedCities(generatedPlan?.plan.city ?? '');
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
      data: generatedPlan?.plan,
    );
  }
}
