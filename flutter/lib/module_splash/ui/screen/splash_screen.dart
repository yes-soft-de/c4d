import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SplashScreen extends StatelessWidget {
  final AuthService _authService;
  final AboutService _aboutService;

  SplashScreen(
    this._authService,
    this._aboutService,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        var isInited = await _aboutService.isInited();

        if (isInited) {
          await Navigator.of(context).pushNamedAndRemoveUntil(
            AboutRoutes.ROUTE_ABOUT,
            (route) => false,
          );
          return;
        }

        var role = await _authService.userRole;

        if (role == UserRole.ROLE_OWNER) {
          await Navigator.of(context).pushNamedAndRemoveUntil(
              OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
          return;
        } else if (role == UserRole.ROLE_CAPTAIN) {
          await Navigator.of(context).pushNamedAndRemoveUntil(
              OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
          return;
        } else {
          await Navigator.of(context).pushNamedAndRemoveUntil(
              AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
          return;
        }
      } catch (e) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
            AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
        return;
      }
    });
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
