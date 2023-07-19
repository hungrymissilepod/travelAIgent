import 'package:flutter_app_template/app/app.logger.dart';
import 'package:flutter_app_template/services/authentication_service.dart';
import 'package:flutter_app_template/services/dio_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_app_template/app/app.locator.dart';
import 'package:flutter_app_template/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _dioService = locator<DioService>();
  final _logger = getLogger('StartupViewModel');

  Future runStartupLogic() async {
    await _dioService.get('');
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
