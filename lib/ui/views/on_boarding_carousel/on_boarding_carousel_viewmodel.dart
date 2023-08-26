import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';

class OnBoardingCarouselViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void onFinish() {
    _navigationService.replaceWithDashboardView();
  }
}
