import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SplashScreen extends StatelessWidget {
  final AuthService _authService;

  SplashScreen(this._authService);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authService.userRole.then((value) {
        if (value == UserRole.ROLE_OWNER) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              OrdersRoutes.OWNER_ORDERS_SCREEN, (route) => false);
        } else if (value == UserRole.ROLE_CAPTAIN) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
        }
      }).catchError((err) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AuthorizationRoutes.LOGIN_SCREEN, (route) => false);
      });
    });
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
