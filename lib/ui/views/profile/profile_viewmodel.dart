import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/misc/constants.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:url_launcher/url_launcher.dart';

enum ProfileViewSection { signOutButton }

class ProfileViewModel extends ReactiveViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final HiveService _hiveService = locator<HiveService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_whoAmIService];

  WhoAmI get whoAmI => _whoAmIService.whoAmI;

  String? get displayName => _whoAmIService.whoAmI.firstName();

  String get userAvatarString => _whoAmIService.whoAmI.firstChar();

  User? get user => _firebaseUserService.user;

  int cheatCounter = 0;
  bool cheatsOn = false;
  bool destinationValidationDisabled = false;

  ProfileViewModel() {
    init();
  }

  bool isUserLoggedIn() => _firebaseUserService.isFullUser();

  String get welcomeMessage {
    if (isUserLoggedIn()) {
      return 'Hey ${_whoAmIService.whoAmI.name}!';
    }
    return 'Hey amigo!';
  }

  Future<void> init() async {
    cheatsOn = await _hiveService.read(HiveKeys.cheatsOn) ?? false;
    destinationValidationDisabled = await _hiveService.read(HiveKeys.destinationValidationDisabled) ?? false;
    rebuildUi();
  }

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

  void onNameFieldTapped() {
    _navigationService.navigateToChangeNameView();
  }

  void setMeasurementSystem(MeasurementSystem system) {
    whoAmI.measurementSystem = system;
    rebuildUi();
    _firestoreService.setMeasurementSystem(user?.uid, system);
  }

  void onRegisterTapped() {
    _navigationService.navigateToRegisterView();
  }

  void onSignInTap() {
    _navigationService.navigateToSignInView();
  }

  void onAboutTapped() {
    _navigationService.navigateToAboutView();
  }

  void onTermsTapped() {
    launchUrl(Uri.parse(termsUrl));
  }

  void onPrivacyTapped() {
    launchUrl(Uri.parse(privacyUrl));
  }

  Future<void> onDeleteAccountTapped() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.deleteUser,
      barrierDismissible: true,
    );
  }

  Future<void> signOut() async {
    List<Future> futures = [
      _firebaseUserService.signOut(),
      _hiveService.clear(),
    ];

    await runBusyFuture(
      Future.wait(futures),
      busyObject: ProfileViewSection.signOutButton,
    );
    _navigationService.clearStackAndShow(Routes.startupView);
  }
}
