import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class AboutService {
  Future<bool> isInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var inited = await preferences.getBool('inited');
    return inited == true;
  }

  Future<void> setInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('inited', true);
  }
}