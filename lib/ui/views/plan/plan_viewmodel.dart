import 'dart:math';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/admob_service.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class PlanViewModel extends BaseViewModel {
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final AdmobService _admobService = locator<AdmobService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  bool get showLoadingBannerAd => _whoAmIService.whoAmI.numPlansGenerated >= 2;

  late Plan? plan;

  bool isSavedPlan = false;

  bool showSaveButton = true;
  bool bookMarkIconFilled = false;

  Destination? get destination => plan?.destination;
  Preferences? get preferences => plan?.preferences;

  String? get _displayName => _whoAmIService.whoAmI.firstName();

  String get _cityName {
    return plan?.city ?? '';
  }

  String title = '';

  String _randomTitle() {
    if (isSavedPlan) {
      return plan?.name ?? '';
    }

    int r = Random().nextInt(9);

    /// If we do not know the users name (before they sign up)
    if (_displayName!.isEmpty ||
        _displayName == null ||
        _displayName == anonymous) {
      switch (r) {
        case 0:
          return 'You\'ll love $_cityName!';
        case 1:
          return 'Welcome to $_cityName!';
        case 2:
          return '$_cityName will sweep you off your feet!';
        case 3:
          return 'We know you\'ll love $_cityName!';
        case 4:
          return 'You\'re going to adore $_cityName!';
        case 5:
          return 'You\'ll fall in love with $_cityName!';
        case 6:
          return 'You\'ll be enchanted by $_cityName!';
        case 7:
          return 'You\'ll have a blast in $_cityName!';
        case 8:
          return '$_cityName ticks all your boxes!';
        default:
          return 'You\'ll love $_cityName!';
      }
    }

    switch (r) {
      case 0:
        return '$_displayName, you\'ll love $_cityName!';
      case 1:
        return '$_displayName, welcome to $_cityName!';
      case 2:
        return '$_displayName, $_cityName will sweep you off your feet!';
      case 3:
        return '$_displayName, we know you\'ll love $_cityName!';
      case 4:
        return '$_displayName, you\'re going to adore $_cityName!';
      case 5:
        return '$_displayName, you\'ll fall in love with $_cityName!';
      case 6:
        return '$_displayName, you\'ll be enchanted by $_cityName!';
      case 7:
        return '$_displayName, you\'ll have a blast in $_cityName';
      case 8:
        return '$_displayName, $_cityName ticks all your boxes!';
      default:
        return '$_displayName, you\'ll love $_cityName!';
    }
  }

  Future<void> generatePlan(Plan? savedPlan) async {
    _admobService.loadAfterSavePlanInterstitialAd();
    clearErrors();

    /// If we are displaying a saved plan, do not generate anything
    if (savedPlan != null) {
      isSavedPlan = true;
      plan = savedPlan;

      title = _randomTitle();
      rebuildUi();
      return;
    }

    /// Generate plan from AI
    plan = await runBusyFuture(_generatorService.generatePlan());

    /// Now fetch images for the plan
    if (plan != null) {
      plan = await runBusyFuture(_generatorService.fetchImages(plan!));
    }
    title = _randomTitle();
    rebuildUi();
    _whoAmIService.whoAmI.numPlansGenerated++;
    _firestoreService.incrementNumPlansGenerated();
  }

  void onTryAgainButtonTap() {
    // _generatorService.addToBlacklistedCities(plan?.city ?? '');
    _navigationService.clearStackAndShow(Routes.planView);
  }

  void onBackButtonTap() {
    if (isSavedPlan) {
      _navigationService.back();
    } else {
      _showInterstitialAd();
      _generatorService.clearBlackList();
      _navigationService.clearStackAndShow(Routes.dashboardView);
    }
  }

  void _showInterstitialAd() async {
    await _admobService.afterSavePlanInterstitialAd?.show();
    _admobService.afterSavePlanInterstitialAd?.dispose();
  }

  void _updateBookMarkIconFilled(bool b) {
    bookMarkIconFilled = b;
    rebuildUi();
  }

  void onSaveTripTap() async {
    _updateBookMarkIconFilled(true);

    // if (!_firebaseUserService.isFullUser()) {
    //   _analyticsService.logEvent('ShowPrompRegisterDialog');
    //   final DialogResponse? response = await _dialogService.showCustomDialog(
    //     variant: DialogType.promptRegister,
    //     barrierDismissible: true,
    //   );
    //   if (response != null) {
    //     if (response.confirmed) {
    //       _showSavePlanDialog();
    //     } else {
    //       _updateBookMarkIconFilled(false);
    //     }
    //   }

    //   return;
    // }

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
    } else {
      _updateBookMarkIconFilled(false);
    }
  }
}
