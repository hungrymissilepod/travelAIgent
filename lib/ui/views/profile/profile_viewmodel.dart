import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  WhoAmI get whoAmI => _whoAmIService.whoAmI;

  User? get user => _firebaseUserService.user;

  Future<void> signOut() async {
    await runBusyFuture(_firebaseUserService.signOut());
    _navigationService.clearStackAndShow(Routes.startupView);
  }
}
