import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class SavedPlansViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  List<Plan> get savedPlans => _whoAmIService.whoAmI.plans.reversed.toList();

  void onSavedPlanCardTap(Plan plan) {
    _navigationService.navigateToPlanView(savedPlan: plan);
  }
}
