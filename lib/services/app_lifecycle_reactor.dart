import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/admob_service.dart';

class AppLifecycleReactor {
  final Logger _logger = getLogger('AppLifecycleReactor');
  final AdmobService admobService;

  AppLifecycleReactor({required this.admobService}) {
    listenToAppStateChanges();
  }

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    _logger.i('_onAppStateChanged: ${appState.name}');

    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      admobService.showAppOpenAdIfAvailable();
    }
  }
}
