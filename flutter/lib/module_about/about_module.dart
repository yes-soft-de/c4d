import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:inject/inject.dart';

@provide
class AboutModule extends YesModule {
  AboutModule(AboutScreenStateManager aboutScreenStateManager) {
    YesModule.RoutesMap.addAll({
      AboutRoutes.ROUTE_ABOUT: (context) => AboutScreen(aboutScreenStateManager),
    });
  }
}