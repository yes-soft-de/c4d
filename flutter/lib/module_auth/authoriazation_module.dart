import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';

import 'authorization_routes.dart';

@provide
class AuthorizationModule extends YesModule {
  final LoginScreen _loginScreen;

  AuthorizationModule(
    this._loginScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      AuthorizationRoutes.LOGIN_SCREEN: (context) => _loginScreen,
    };
  }
}
