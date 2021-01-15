import 'dart:async';

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/states/auth_states/auth_states.dart';
import 'package:c4d/module_auth/state_manager/auth_state_manager/auth_state_manager.dart';
import 'package:c4d/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:c4d/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  final AuthStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthState _currentState = AuthStateInit();
  bool loading = false;
  String redirectTo;
  USER_TYPE userType = USER_TYPE.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: USER_TYPE.ROLE_OWNER.index);

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  @override
  void initState() {
    super.initState();

    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      loading = false;
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
      processEvent();
    });
  }

  void processEvent() {
    redirectTo = userType == USER_TYPE.ROLE_OWNER
        ? OrdersRoutes.OWNER_ORDERS_SCREEN
        : OrdersRoutes.CAPTAIN_ORDERS_SCREEN;
    if (_currentState is AuthStateAuthSuccess) {
      _stateSubscription.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(redirectTo, (r) => false);
    }
    if (_currentState is AuthStateNotRegisteredOwner) {
      _stateSubscription.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(redirectTo, (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget._stateManager.checkLoggedIn();
    return loginUi();
  }

  Widget loginUi() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 96,
              child: _getHeaderRow(),
            ),
            Expanded(
                child: PageView(
              controller: loginTypeController,
              onPageChanged: (pos) {
                userType = USER_TYPE.values[pos];
                setState(() {});
              },
              children: [
                PhoneLoginWidget(
                  codeSent: _currentState is AuthStateCodeSent,
                  loading: loading,
                  onLoginRequested: (phone) {
                    loading = true;
                    widget._stateManager.signInWithPhone(phone);
                  },
                  onRetry: () {
                    _currentState = AuthStateInit();
                    loading = false;
                    setState(() {});
                  },
                  onConfirm: (confirmCode) {
                    widget._stateManager.confirmWithCode(confirmCode, userType);
                  },
                ),
                EmailPasswordForm(
                  loading: loading,
                  onLoginRequest: (email, password) {
                    widget._stateManager.signInWithEmailAndPassword(
                      email,
                      password,
                      userType,
                    );
                  },
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _getErrorMessages(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getHeaderRow() {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: 300,
              child: AnimatedAlign(
                  duration: Duration(milliseconds: 300),
                  alignment: userType == USER_TYPE.ROLE_CAPTAIN
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' '),
                    ), // For Sizing
                  )),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          userType = USER_TYPE.ROLE_CAPTAIN;
                          loginTypeController.jumpToPage(userType.index);
                        });
                      },
                      child: Text(
                        S.of(context).captain,
                        style: TextStyle(
                          color: userType == USER_TYPE.ROLE_CAPTAIN
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          userType = USER_TYPE.ROLE_OWNER;
                          loginTypeController.jumpToPage(userType.index);
                        });
                      },
                      child: Text(
                        S.of(context).storeOwner,
                        style: TextStyle(
                          color: userType != USER_TYPE.ROLE_CAPTAIN
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getErrorMessages() {
    if (_currentState is AuthStateError) {
      AuthStateError state = _currentState;
      return Text(
        state.errorMsg,
        maxLines: 2,
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }
}
