import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_aigent/app/app.bottomsheets.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:travel_aigent/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  Need to remember to attribute artist from storyset for using their artwork:
  <a href="https://storyset.com/people">People illustrations by Storyset</a>
  
  https://support.flaticon.com/s/article/Attribution-How-when-and-where-FI?language=en_US#:~:text=Place%20the%20attribution%20on%20the,the%20post%20or%20post%20comments

  Apps/games:

  Place the attribution on the app's credits page and on the description page on the app store.
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load();

  /// For some reason we get an error when passing in [options] when running on iOS
  await Firebase.initializeApp(
    options: Platform.isIOS ? null : DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await ThemeManager.initialise();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        lightTheme: Colours.lightTheme,
        darkTheme: Colours.darkTheme,
        builder: (BuildContext context, ThemeData? regularTheme, ThemeData? darkTheme, ThemeMode? themeMode) {
          return MaterialApp(
            theme: regularTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            initialRoute: Routes.startupView,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            navigatorObservers: [
              StackedService.routeObserver,
              observer,
            ],
          );
        });
  }
}
