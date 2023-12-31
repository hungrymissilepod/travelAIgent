import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';

class WhoAmIService with ListenableServiceMixin {
  WhoAmIService() {
    listenToReactiveValues([whoAmI]);
  }

  WhoAmI whoAmI = WhoAmI(plans: <Plan>[]);

  void setName(String name) {
    whoAmI.name = name;
    notifyListeners();
  }

  void setWhoAmI(Map<String, dynamic> data) {
    whoAmI = WhoAmI.fromJson(data);
  }

  void addPlan(Plan plan) {
    whoAmI.plans.add(plan);
  }

  void reset() {
    whoAmI = WhoAmI.empty();
  }
}
