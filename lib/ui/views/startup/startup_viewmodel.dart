import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/ip_service.dart';

class StartupViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final IpService _ipService = locator<IpService>();
  final AirportService _airportService = locator<AirportService>();
  final HiveService _hiveService = locator<HiveService>();

  final Logger _logger = getLogger('StartupViewModel');

  /// Whether to show the Get Started and Sign In buttons
  /// used for user's first time launch
  bool showLaunchButtons = false;

  Future<void> runStartupLogic() async {
    /// Initialise GPT
    OpenAI.apiKey = dotenv.env['TRAVEL_AIGENT_OPEN_AI_API_KEY']!;

    await Future.wait([
      _hiveService.init(),
      _airportService.loadAirports(),
      _ipService.getUserLocation(),
    ]);

    /// Get users closest airport
    _airportService.getDefaultFromValue();

    await _getOrCreateUser();
  }

  Future<void> _getOrCreateUser() async {
    /// Anonymous user comes back to the app
    if (_firebaseUserService.isAnonymousUser()) {
      _navigationService.replaceWithDashboardView();
      return;
    }

    /// If a full user comes back to the app
    if (_firebaseUserService.isUserLoggedIn()) {
      _logger.i('User is logged in');
      if (await _firestoreService.getUser()) {
        _logger.i('Downloaded user data');
        _navigationService.replaceWithDashboardView();
        return;
      } else {
        _logger.i('Failed to download user data');
        _firebaseUserService.signOut();
      }
    }

    /// This is user's first time launching the app
    showLaunchButtons = true;
    rebuildUi();
  }

  void onGetStartedTap() async {
    _authenticationService.createAnonymousUser();
    _navigationService.replaceWithOnBoardingCarouselView();
  }

  void onSignInTap() {
    _navigationService.navigateTo(
      Routes.signInView,
      arguments: const SignInViewArguments(showSignUpButton: false),
    );
  }
}
