import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

enum ProfileViewSection { signOutButton }

class ProfileViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final HiveService _hiveService = locator<HiveService>();

  ProfileViewModel() {
    init();
  }

  Future<void> init() async {
    cheatsOn = await _hiveService.read(HiveKeys.cheatsOn) ?? false;
    destinationValidationDisabled = await _hiveService.read(HiveKeys.destinationValidationDisabled) ?? false;
    rebuildUi();
  }

  int cheatCounter = 0;
  bool cheatsOn = false;
  bool destinationValidationDisabled = false;

  void onAvatarTapped() {
    cheatCounter++;

    if (cheatCounter > 10) {
      cheatsOn = !cheatsOn;
      rebuildUi();
      _hiveService.write(HiveKeys.cheatsOn, cheatsOn);
      cheatCounter = 0;
    }
  }

  void onDestinationValidationTapped() async {
    destinationValidationDisabled = !destinationValidationDisabled;
    rebuildUi();
    await _hiveService.write(HiveKeys.destinationValidationDisabled, destinationValidationDisabled);
    _navigationService.clearStackAndShow(Routes.dashboardView);
  }

  void testOnBoarding() {
    _navigationService.clearStackAndShow(Routes.onBoardingCarouselView);
  }

  WhoAmI get whoAmI => _whoAmIService.whoAmI;

  User? get user => _firebaseUserService.user;

  bool userSelectedMeasurementSystem(MeasurementSystem system) {
    return whoAmI.measurementSystem == system;
  }

  void setMeasurementSystem(MeasurementSystem system) {
    whoAmI.measurementSystem = system;
    rebuildUi();
    _firestoreService.setMeasurementSystem(user?.uid, system);
  }

  Future<void> onDeleteAccountTapped() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.deleteUser,
      barrierDismissible: true,
    );
  }

  Future<void> signOut() async {
    await runBusyFuture(
      _firebaseUserService.signOut(),
      busyObject: ProfileViewSection.signOutButton,
    );
    _navigationService.clearStackAndShow(Routes.startupView);
  }

  String get userAvatarString {
    return _whoAmIService.whoAmI.firstChar();
  }
}
