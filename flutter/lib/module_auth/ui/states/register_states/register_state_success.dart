import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';

class RegisterStateSuccess extends RegisterState {
  RegisterStateSuccess(RegisterScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      screen.moveToNext();
    });
    return Column(
      children: [
        Center(child: Text('Login Success')),
      ],
    );
  }
}
