import 'package:flutter/material.dart';

class Colours {
  // static Color darkBlueBlack = Color(0xFF0B2647);
  static Color blue = const Color(0xFF206BC7);

  static const int _primaryPrimaryValue = 0xff484650;

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    <int, Color>{
      50: Color(0xffe9e9ea),
      100: Color(0xffc8c8cb),
      200: Color(0xffa4a3a8),
      300: Color(0xff7f7e85),
      400: Color(0xff63626a),
      500: Color(0xff484650),
      600: Color(0xff413f49),
      700: Color(0xff383740),
      800: Color(0xff302f37),
      900: Color(0xff212027),
    },
  );

  static const int _primaryAccentValue = 0xffff8c43;

  static const MaterialColor accent = MaterialColor(
    _primaryAccentValue,
    <int, Color>{
      50: Color(0xfffff1e8),
      100: Color(0xffffddc7),
      200: Color(0xffffc6a1),
      300: Color(0xffffaf7b),
      400: Color(0xffff9d5f),
      500: Color(0xffff8c43),
      600: Color(0xffff843d),
      700: Color(0xffff7934),
      800: Color(0xffff6f2c),
      900: Color(0xffff5c1e),
    },
  );

  static const int _primaryErrorValue = 0xffba1a1a;

  static const MaterialColor error = MaterialColor(
    _primaryErrorValue,
    <int, Color>{
      50: Color(0xfff7e4e4),
      100: Color(0xffeababa),
      200: Color(0xffdd8d8d),
      300: Color(0xffcf5f5f),
      400: Color(0xffc43c3c),
      500: Color(0xffba1a1a),
      600: Color(0xffb31717),
      700: Color(0xffab1313),
      800: Color(0xffa30f0f),
      900: Color(0xff940808),
    },
  );

  static TextTheme textTheme = const TextTheme(
    /// WelcomeCard and other places
    displayLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    /// AppBar title
    headlineLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colours.primary,
    primaryColorDark: Colours.primary.shade700,
    primaryColorLight: Colours.primary.shade200,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colours.primary,
        primaryColorDark: Colours.primary.shade700,
        accentColor: Colours.accent,
        errorColor: Colours.error,
        backgroundColor: Colors.white),
    textTheme: textTheme,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colours.primary.shade700,
    primaryColorDark: Colours.primary.shade100,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colours.accent,
      errorColor: Colours.error,
      backgroundColor: Colours.primary.shade700,
    ),
    textTheme: textTheme.copyWith(bodyLarge: const TextStyle(color: Colors.white)),
  );
}

BoxDecoration textFieldDecoration(FocusNode focusNode, bool hasError) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      width: textFieldBorderWidth,
      color: hasError
          ? Colors.red
          : focusNode.hasFocus
              ? Colours.accent
              : Colors.black26,
    ),
  );
}

const double homePickerHeight = 50;
const double scaffoldHorizontalPadding = 20;

const double textFieldBorderWidth = 1.4;

const double textFieldIconSizedBoxWidth = 20;
const double textFieldIconSpacer = 12;
const double textFieldContainerPadding = 8;
const double textFieldIconSize = 16;
