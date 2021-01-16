import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_settings/setting_routes.dart';
import 'package:c4d/module_settings/ui/settings_page/settings_page.dart';
import 'package:inject/inject.dart';

@provide
class SettingsModule extends YesModule {
  final SettingsScreen _settingsScreen;

  SettingsModule(this._settingsScreen) {
    YesModule.RoutesMap.addAll({
      SettingRoutes.ROUTE_SETTINGS: (context) => _settingsScreen
    });
  }
}