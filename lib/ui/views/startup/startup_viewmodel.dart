import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:system_proxy/system_proxy.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/http_proxy_service.dart';
import 'package:travel_aigent/services/image_scraper_service.dart';
import 'package:travel_aigent/services/ip_service.dart';

class StartupViewModel extends BaseViewModel {
  final FirebaseUserService _firebaseUserService = locator<FirebaseUserService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final IpService _ipService = locator<IpService>();
  final AirportService _airportService = locator<AirportService>();
  final ImageScraperService _imageScraperService = locator<ImageScraperService>();
  final DioService _dioService = locator<DioService>();

  final HttpProxyService _httpProxyService = locator<HttpProxyService>();

  final Logger _logger = getLogger('StartupViewModel');

  Future<void> runStartupLogic() async {
    // Map<String, String>? proxy = await SystemProxy.getProxySettings();
    // if (proxy == null) {
    //   proxy = {'host': 'null', 'port': 'null'};
    // }
    // HttpOverrides.global = ProxiedHttpOverrides(proxy['host']!, proxy['port']!);

    await _httpProxyService.init();

    // return;

    // await _dioService.setUpProxy();
    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIzMTE5NzFjLTY3OTEtNDhhMC05ZmJlLThkMWY2ZjQ1MmRiNyIsImVtYWlsIjoiamFrZS5raW5nbGVlQGd';
    // await _dioService.get('https://www.google.com', headers: {'Authorization': 'Token $token'});
    // await _imageScraperService.getImages('dog');
    // return;

    await _airportService.loadAirports();

    /// Initialise GPT
    OpenAI.apiKey = dotenv.env['TRAVEL_AIGENT_OPEN_AI_API_KEY']!;
    await _ipService.getUserLocation();
    _airportService.getDefaultFromValue();

    await _getOrCreateUser();
    _navigationService.replaceWith(Routes.dashboardView);
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
