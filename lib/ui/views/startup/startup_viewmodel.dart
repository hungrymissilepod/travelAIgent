import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _logger = getLogger('StartupViewModel');

  Future runStartupLogic() async {
    // 2. Check if the user is logged in
    if (_authenticationService.userLoggedIn()) {
      _logger.i('User is logged in');
      // 3. Navigate to HomeView
      _navigationService.replaceWith(Routes.homeView, arguments: const HomeViewArguments(startingIndex: 111));
    } else {
      _logger.i('User is NOT logged in');
      // 4. Or navigate to LoginView
      _navigationService.replaceWith(Routes.loginView);
    }
  }
}
