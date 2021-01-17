import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:flutter/material.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool loading = false;

  LoginStateInit(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 36,
            child: UserTypeSelector(
              currentUserType: userType,
              onUserChange: (newType) {
                userType = newType;
                loginTypeController.animateToPage(
                  userType.index,
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                );
              },
            ),
          ),
          Expanded(
              child: PageView(
            controller: loginTypeController,
            onPageChanged: (pos) {
              userType = UserRole.values[pos];
              screen.refresh();
            },
            children: [
              PhoneLoginWidget(
                codeSent: false,
                loading: loading,
                onLoginRequested: (phone) {
                  loading = true;
                  screen.loginCaptain(phone);
                },
                onRetry: () {},
                onConfirm: (confirmCode) {
                  screen.confirmCaptainSMS(confirmCode);
                },
              ),
              EmailPasswordForm(
                loading: loading,
                onLoginRequest: (email, password) {
                  screen.loginOwner(
                    email,
                    password,
                  );
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
