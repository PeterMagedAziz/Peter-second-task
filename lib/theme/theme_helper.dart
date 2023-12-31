import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found or not generated by the generator
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    //return theme from map

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      colorScheme: colorScheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                0,
              ),
              topRight: Radius.circular(
                0,
              ),
              bottomLeft: Radius.circular(
                6,
              ),
              bottomRight: Radius.circular(
                6,
              ),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                0,
              ),
              topRight: Radius.circular(
                0,
              ),
              bottomLeft: Radius.circular(
                6,
              ),
              bottomRight: Radius.circular(
                0,
              ),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: colorScheme.onPrimaryContainer.withOpacity(1),
          fontSize: getFontSize(
            26,
          ),
          fontFamily: 'Gemunu Libre',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontSize: getFontSize(
            22,
          ),
          fontFamily: 'Gemunu Libre',
          fontWeight: FontWeight.w400,
        ),
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    background: Color(0XFFFBFBFB),
    error: Color(0XFFFBFBFB),
    errorContainer: Color(0XFF8249B5),
    inversePrimary: Color(0XFFFBFBFB),
    inverseSurface: Color(0XFFFBFBFB),
    onBackground: Color(0XB2323232),
    onError: Color(0XB2323232),
    onErrorContainer: Color(0XFFFBFBFB),
    onInverseSurface: Color(0XB2323232),
    onPrimary: Color(0XFFFBFBFB),
    onPrimaryContainer: Color(0XB2323232),
    onSecondary: Color(0XB2323232),
    onSecondaryContainer: Color(0XFFFBFBFB),
    onSurface: Color(0XB2323232),
    onSurfaceVariant: Color(0XFFFBFBFB),
    onTertiary: Color(0XB2323232),
    onTertiaryContainer: Color(0XFFFBFBFB),
    outline: Color(0XFFFBFBFB),
    outlineVariant: Color(0XFFFBFBFB),
    primary: Color(0XFF8249B5),
    primaryContainer: Color(0XFFFBFBFB),
    scrim: Color(0XFFFBFBFB),
    secondary: Color(0XFFFBFBFB),
    secondaryContainer: Color(0XFF8249B5),
    shadow: Color(0XFFFBFBFB),
    surface: Color(0XFFFBFBFB),
    surfaceTint: Color(0XFFFBFBFB),
    surfaceVariant: Color(0XFF8249B5),
    tertiary: Color(0XFFFBFBFB),
    tertiaryContainer: Color(0XFF8249B5),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);
  // BlueGray
  Color get blueGray400 => Color(0XFF808194);
  Color get blueGray40001 => Color(0XFF888888);
  // DeepPurple
  Color get deepPurpleA700 => Color(0XFF5D13E7);
  // White
  Color get whiteA700 => Color(0XFFFFFFFF);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
