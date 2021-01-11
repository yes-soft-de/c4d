import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class ThemePreferencesHelper {
  Future<void> setDarkMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('dark', true);
  }

  Future<void> setDayMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('dark', false);
  }

  Future<bool> isDarkMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool dark = await preferences.getBool('dark');
    return dark == true;
  }
}
