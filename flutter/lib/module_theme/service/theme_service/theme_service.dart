import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';

@provide
class AppThemeDataService {
  static final PublishSubject<ThemeData> _darkModeSubject =
      PublishSubject<ThemeData>();
  Stream<ThemeData> get darkModeStream => _darkModeSubject.stream;

  final ThemePreferencesHelper _preferencesHelper;

  AppThemeDataService(this._preferencesHelper);

  static Color get PrimaryColor {
    return Color(0xFF3ACCE1);
  }

  static Color get PrimaryDarker {
    return Color(0xFF665EFF);
  }

  static Color get AccentColor {
    return Color(0xFFBE1E2D);
  }

  Future<ThemeData> getActiveTheme() async {
    var dark = await _preferencesHelper.isDarkMode();
    if (dark == true) {
      return ThemeData(
        brightness: Brightness.dark,
        primaryColor: PrimaryColor,
        primaryColorDark: PrimaryDarker,
        accentColor: AccentColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.black,
        ),
      );
    }
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryDarker,
      accentColor: AccentColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.white,
      ),
    );
  }

  Future<void> switchDarkMode(bool darkMode) async {
    if (darkMode) {
      await _preferencesHelper.setDarkMode();
    } else {
      await _preferencesHelper.setDayMode();
    }
    var activeTheme = await getActiveTheme();
    _darkModeSubject.add(activeTheme);
  }
}
