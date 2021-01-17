import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';

class LoginStateSuccess extends LoginState {
  LoginStateSuccess(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(OrdersRoutes.OWNER_ORDERS_SCREEN);
    });
    return Column(
      children: [
        Text('Login Success'),
      ],
    );
  }
}
