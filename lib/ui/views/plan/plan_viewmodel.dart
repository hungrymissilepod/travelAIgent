import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/generator_service.dart';

class PlanViewModel extends BaseViewModel {
  final GeneratorService _generatorService = locator<GeneratorService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('GeneratorService');

  Plan? plan;

  Future<void> generatePlan() async {
    plan = await runBusyFuture(_generatorService.generatePlan2());
  }

  void onContinueButtonTap() {
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }
}
