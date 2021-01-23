import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_localization/service/localization_service/localization_service.dart';
import 'package:inject/inject.dart';

@provide
class AboutScreenStateManager {
  final LocalizationService _localizationService;
  AboutScreenStateManager(this._localizationService);

  void setLanguage(String lang) {
    _localizationService.setLanguage(lang);
  }

  void showAbout(UserRole role) {

  }
}