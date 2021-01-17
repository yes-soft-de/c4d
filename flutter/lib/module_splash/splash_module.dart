import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_splash/splash_routes.dart';
import 'package:c4d/module_splash/ui/screen/splash_screen.dart';
import 'package:inject/inject.dart';

@provide
class SplashModule extends YesModule {
  SplashModule(SplashScreen splashScreen) {
    YesModule.RoutesMap.addAll({
      SplashRoutes.SPLASH_SCREEN: (context) => splashScreen
    });
  }
}