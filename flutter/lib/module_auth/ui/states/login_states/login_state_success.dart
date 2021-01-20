import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginStateSuccess extends LoginState {
  LoginStateSuccess(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/animations/register-success.json'),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          padding: EdgeInsets.all(16),
          onPressed: () {
            screen.moveToNext();
          },
          child: Text('Welcome to C4D'),
        )
      ],
    );
  }
}
