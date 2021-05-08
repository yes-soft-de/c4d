import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:flutter/material.dart';

import '../../../authorization_routes.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_OWNER;
  var loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool flag = true;
  LoginStateInit(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    UserRole userRole = ModalRoute.of(context).settings.arguments;
    if (flag && userRole != null) {
      loginTypeController = PageController(initialPage: userRole.index);
      userType = userRole;
      flag = false;
    }
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 36,
              child: UserTypeSelector(
                currentUserType: userType,
                onUserChange: (newType) {
                  userType = newType;
                  screen.refresh();
                  loginTypeController.animateToPage(
                    userType.index,
                    duration: Duration(seconds: 1),
                    curve: Curves.linear,
                  );
                },
              ),
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
                onLoginRequested: (phone) {
                  screen.setRole(userType);
                  screen.refresh();
                  screen.loginCaptain(phone);
                },
                onAlterRequest: () {
                  Navigator.of(context).pushNamed(
                      AuthorizationRoutes.REGISTER_SCREEN,
                      arguments: userType);
                },
                isRegister: false,
                onRetry: () {
                  screen.retryPhone();
                },
                onConfirm: (confirmCode) {
                  screen.refresh();
                  screen.confirmCaptainSMS(confirmCode);
                },
              ),
              EmailPasswordForm(
                onLoginRequest: (email, password) {
                  screen.setRole(userType);
                  screen.refresh();
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
