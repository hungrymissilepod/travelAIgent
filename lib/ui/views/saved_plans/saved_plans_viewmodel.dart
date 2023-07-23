import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';

class SavedPlansViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onSavedPlanCardTap(Plan plan) {
    _navigationService.navigateToPlanView(savedPlan: plan);
  }
}
