import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  WhoAmI get whoAmI => _whoAmIService.whoAmI;

  User? get user => _authenticationService.user;

  Future<void> signOut() async {
    await runBusyFuture(_authenticationService.signOut());

    /// TODO: this should sign the user out, clear any caches with user data, go back to DashboardScreen
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }
}