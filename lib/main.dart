import 'package:flutter/material.dart';
import 'package:travel_aigent/app/app.bottomsheets.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

/*
  Need to remember to attribute artist from storyset for using their artwork:
  <a href="https://storyset.com/people">People illustrations by Storyset</a>
  
  https://support.flaticon.com/s/article/Attribution-How-when-and-where-FI?language=en_US#:~:text=Place%20the%20attribution%20on%20the,the%20post%20or%20post%20comments

  Apps/games:

  Place the attribution on the app's credits page and on the description page on the app store.
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeManager.initialise();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
            ],
          );
        });
  }
}
