import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class NotificationsPrefsHelper {
  Future<void> setIsActive(bool active) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('captain_active', active);
  }

  Future<bool> getIsActive() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('captain_active');
  }

  Future<void> setBackgroundData(dynamic json) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('background Notification', json);
  }
  Future<String> getBackgroundData() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('background Notification');
  }
    Future<void> setLaunch(dynamic json) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('launch Notification', json);
  }
  Future<String> getLaunch() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('launch Notification');
  }
}
