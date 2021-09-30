import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_register/email_password_register.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:c4d/utils/helper/custom_alert_bar.dart';
import 'package:flutter/material.dart';

class RegisterStateInit extends RegisterState {
  UserRole userType = UserRole.ROLE_OWNER;
  var registerTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool flag = true;
  final RegisterScreenState screen;
  RegisterStateInit(this.screen, {String error}) : super(screen) {
    if (error != null){
 CustomFlushBarHelper.createError(
          title: S.current.warnning, message: error).show(this.screen.context);
    }
  }

  @override
  Widget getUI(BuildContext context) {
    UserRole userRole = ModalRoute.of(context).settings.arguments;
    if (flag && userRole != null) {
      registerTypeController = PageController(initialPage: userRole.index);
      userType = userRole;
      flag = false;
    }
    return Column(
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
                registerTypeController.animateToPage(
                  userType.index,
                  curve: Curves.linear,
                  duration: Duration(seconds: 1),
                );
              },
            ),
          ),
        ),
        Expanded(
            child: PageView(
          controller: registerTypeController,
          onPageChanged: (pos) {
            userType = UserRole.values[pos];
            screen.refresh();
          },
          children: [
            CaptainLoginWidget(
              onLoginRequested: (username, password) {
                screen.setRole(userType);
                screen.refresh();
                screen.registerCaptain(username, '', password);
              },
              onAlterRequest: () {
                Navigator.of(context)
                    .pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
              },
              isRegister: true,
              loading: screen.loadingSnapshot == AsyncSnapshot.waiting(),
            ),
            EmailPasswordRegisterForm(
              onRegisterRequest: (name, username, password) {
                screen.setRole(userType);
                screen.refresh();
                screen.registerOwner(
                  username,
                  name,
                  password,
                );
              },
            ),
          ],
        )),
      ],
    );
  }
}
