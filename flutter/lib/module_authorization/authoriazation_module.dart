

import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_authorization/authorization_routes.dart';
import 'package:c4d/module_authorization/ui/screen/login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:inject/inject.dart';

@provide
class AuthorizationModule extends YesModule {
  final LoginScreen _loginScreen;

  AuthorizationModule(
      this._loginScreen,
      );

  @override
  Map<String,WidgetBuilder> getRoutes() {
    return{
      AuthorizationRoutes.AUTHORIZATION_SCREEN: (context) => _loginScreen,
    };
  }
}