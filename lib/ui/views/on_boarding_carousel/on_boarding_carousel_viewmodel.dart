import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/hive_service.dart';

class OnBoardingCarouselViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final HiveService _hiveService = locator<HiveService>();

  void onFinish() {
    _hiveService.write(HiveKeys.onBoardingCarouselSeen, true);
    _navigationService.replaceWithDashboardView();
  }
}
