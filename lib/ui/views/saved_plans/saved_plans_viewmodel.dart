import 'dart:math';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class SavedPlansViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  bool get showAds => _whoAmIService.whoAmI.plans.length >= 3;

  TemplateType templateType = TemplateType.small;

  List<Plan> get savedPlans => _whoAmIService.whoAmI.plans.reversed.toList();

  SavedPlansViewModel() {
    int r = Random().nextInt(4);
    if (r == 0) {
      templateType = TemplateType.medium;
    }
  }

  void onSavedPlanCardTap(Plan plan) {
    _navigationService.navigateToPlanView(savedPlan: plan);
  }

  void onGenerateTripCTATapped() {}
}
