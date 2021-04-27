import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_register/email_password_register.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:flutter/material.dart';

class RegisterStateInit extends RegisterState {
  UserRole userType = UserRole.ROLE_OWNER;
  var registerTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool loading = false;
  bool flag = true;
  RegisterStateInit(RegisterScreenState screen) : super(screen);

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
            PhoneLoginWidget(
              codeSent: false,
              onLoginRequested: (phone) {
                loading = true;
                screen.refresh();
                screen.registerCaptain(phone);
              },
              onAlterRequest: () {
                Navigator.of(context).pop();
              },
              isRegister: true,
              onConfirm: (confirmCode) {
                loading = true;
                screen.refresh();
                screen.confirmCaptainSMS(confirmCode);
              },
            ),
            EmailPasswordRegisterForm(
              onRegisterRequest: (email, password, name) {
                loading = true;
                screen.refresh();
                screen.registerOwner(
                  email,
                  email,
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
