import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/widget/email_password_register/email_password_register.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_auth/ui/widget/user_type_selector/user_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterStateError extends RegisterState {
  String errorMsg;
  UserRole userType = UserRole.ROLE_OWNER;
  var registerTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool loading = false;
  bool flag = true;
  RegisterStateError(RegisterScreenState screen, this.errorMsg) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    UserRole userRole = screen.getInitRole;
    if (userRole != null && flag) {
      registerTypeController = PageController(initialPage: userRole.index);
      userType = userRole;
      flag = false;
    }
    if (loading) {
      Future.delayed(Duration(seconds: 30)).then((value) {
        loading = false;
        screen.refresh();
      });
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
              onRetry: () {
                screen.retryPhone();
              },
              onConfirm: (confirmCode) {
                loading = true;
                screen.refresh();
                screen.confirmCaptainSMS(confirmCode);
              },
            ),
            EmailPasswordRegisterForm(
              onRegisterRequest: (email, password, name) {
                screen.registerOwner(
                  email,
                  email,
                  password,
                );
              },
            ),
          ],
        )),
        MediaQuery.of(context).viewInsets.bottom == 0
            ? Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMsg,
                    maxLines: 3,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
