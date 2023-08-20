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
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final IpService _ipService = locator<IpService>();
  final AirportService _airportService = locator<AirportService>();
  final HiveService _hiveService = locator<HiveService>();

  final Logger _logger = getLogger('StartupViewModel');

  Future<void> runStartupLogic() async {
    /// Initialise GPT
    OpenAI.apiKey = dotenv.env['TRAVEL_AIGENT_OPEN_AI_API_KEY']!;

    await Future.wait([
      _hiveService.init(),
      _airportService.loadAirports(),
      _ipService.getUserLocation(),
      _getOrCreateUser(),
    ]);

    /// Get users closest airport
    _airportService.getDefaultFromValue();

    /// Navigate to OnBoarding Carousel if user not seen it
    final bool? hasSeenOnBoardingCarousel = await _hiveService.read(HiveKeys.onBoardingCarouselSeen);
    if (hasSeenOnBoardingCarousel == null || hasSeenOnBoardingCarousel == false) {
      _navigationService.replaceWithOnBoardingCarouselView();
      return;
    }

    _navigationService.replaceWithDashboardView();
  }

  Future<void> _getOrCreateUser() async {
    if (_firebaseUserService.isUserLoggedIn()) {
      _logger.i('User is logged in');
      if (await _firestoreService.getUser()) {
        _logger.i('Downloaded user data');
        return;
      } else {
        _logger.i('Failed to download user data');
        _firebaseUserService.signOut();
      }
    }

    /// If user is launching app for first time, or if
    /// we fail to fetch user data, create them an anonymous account
    _logger.i('Creating anonymous user account');
    await _authenticationService.createAnonymousUser();
  }
}
