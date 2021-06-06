import 'package:c4d/module_about/about_routes.dart';
import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SplashScreen extends StatelessWidget {
  final AuthService _authService;
  final AboutService _aboutService;
  final ProfileService _profileService;

  SplashScreen(
    this._authService,
    this._aboutService,
    this._profileService,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }

  Future<String> _getNextRoute() async {
    try {
      var isInited = await _aboutService.isInited();

      if (!isInited) {
        return AboutRoutes.ROUTE_ABOUT;
      }
      var role = await _authService.userRole;

      if (role == UserRole.ROLE_OWNER) {
        return OrdersRoutes.OWNER_ORDERS_SCREEN;
      } else if (role == UserRole.ROLE_CAPTAIN) {
        return OrdersRoutes.CAPTAIN_ORDERS_SCREEN;
      } else {
        return AuthorizationRoutes.LOGIN_SCREEN;
      }
    } catch (e) {
      return AboutRoutes.ROUTE_ABOUT;
    }
  }
}
