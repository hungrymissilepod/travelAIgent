import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';

class SavePlanDialogModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  // late final Plan plan;

  SavePlanDialogModel(Plan plan) {
    // plan = plan;
    // print(plan.toJson());
  }

  Future<void> onSaveTap() async {
    await runBusyFuture(Future.delayed(const Duration(seconds: 2)));

    /// TODO: save this plan to user storage
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }

  void onCancelTap() {
    _navigationService.back();
  }
}
