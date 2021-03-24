import 'package:c4d/module_about/manager/about_manager.dart';
import 'package:c4d/module_about/request/create_appointment_request.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class AboutService {
  final AboutManager _manager;
  AboutService(this._manager);

  Future<bool> isInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var inited = await preferences.getBool('inited');
    return inited == true;
  }

  Future<void> setInited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('inited', true);
  }

  Future<bool> createAppointment(String name, String phoneNumber) async {
    await _manager.createAppointment(CreateAppointmentRequest(name, phoneNumber));
    return true;
  }
}