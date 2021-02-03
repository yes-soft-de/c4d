import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:inject/inject.dart';

@provide
class AboutScreenStateManager {
  final LocalizationService _localizationService;
  final AboutService _aboutService;
  AboutScreenStateManager(this._localizationService, this._aboutService);

  void setLanguage(String lang) {
    _localizationService.setLanguage(lang);
  }

  void setInited(AboutScreenState screenState) {
    _aboutService.setInited().then((value) {
      screenState.moveToRegister();
    });
  }

  void createAppointment(AboutScreenState screenState, String name, String phone) {
    _aboutService.createAppointment(name, phone).then((value) {
      screenState.setBookingSuccess();
    });
  }
}