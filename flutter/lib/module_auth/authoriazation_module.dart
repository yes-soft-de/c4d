import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';

import 'authorization_routes.dart';

@provide
class AuthorizationModule extends YesModule {
  final LoginScreen _loginScreen;
  final RegisterScreen _registerScreen;

  AuthorizationModule(this._loginScreen, this._registerScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => _loginScreen,
      AuthorizationRoutes.REGISTER_SCREEN: (context) => _registerScreen,
    };
  }
}
