import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/services/firestore_service.dart';

class StartupViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('StartupViewModel');

  Future runStartupLogic() async {
    /// Initialise GPT
    OpenAI.apiKey = dotenv.env['TRAVEL_AIGENT_OPEN_AI_API_KEY']!;

    if (_authenticationService.userLoggedIn()) {
      _logger.i('User is logged in');
      await _firestoreService.getUser();
    } else {
      _logger.i('User is NOT logged in');
    }

    _navigationService.replaceWith(Routes.dashboardView);
  }
}
