import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:c4d/utils/helper/custom_alert_bar.dart';
import 'package:flutter/material.dart';

import '../../../authorization_routes.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_OWNER;
  var loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool flag = true;
  final LoginScreenState screenState;
  LoginStateInit(this.screenState, {String error}) : super(screenState) {
    if (error != null) {
      CustomFlushBarHelper.createError(
          title: S.current.warnning, message: error).show(this.screenState.context);
    }
  }

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
                  screenState.refresh();
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
              screenState.refresh();
            },
            children: [
              CaptainLoginWidget(
                onLoginRequested: (username, password) {
                  screenState.setRole(userType);
                  screenState.refresh();
                  screenState.loginCaptain(username, password);
                },
                onAlterRequest: () {
                  Navigator.of(context).pushNamed(
                      AuthorizationRoutes.REGISTER_SCREEN,
                      arguments: userType);
                },
                isRegister: false,
                loading: screenState.loadingSnapshot == AsyncSnapshot.waiting(),
              ),
              OwnerLoginForm(
                onLoginRequest: (username, password) {
                  screenState.setRole(userType);
                  screenState.refresh();
                  screenState.loginOwner(
                    username,
                    password,
                  );
                },
                loading: screenState.loadingSnapshot == AsyncSnapshot.waiting(),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
