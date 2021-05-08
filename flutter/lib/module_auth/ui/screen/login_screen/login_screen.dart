import 'dart:async';

import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class LoginScreen extends StatefulWidget {
  final LoginStateManager _stateManager;

  LoginScreen(this._stateManager);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  UserRole currentUserRole;

  LoginState _currentStates;

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;
  UserRole initRole;
  UserRole get getInitRole => this.initRole;

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentStates = LoginStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
          _currentStates = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _currentStates.getUI(context),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void moveToNext(bool inited) {
    if (!inited) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          InitAccountRoutes.INIT_ACCOUNT_SCREEN, (r) => false);
      return;
    }
    if (currentUserRole == UserRole.ROLE_OWNER) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OrdersRoutes.OWNER_ORDERS_SCREEN, (r) => false);
    } else if (currentUserRole == UserRole.ROLE_CAPTAIN) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (r) => false);
    }
  }

  void loginCaptain(String phoneNumber) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.loginCaptain(phoneNumber, this);
  }

  void loginOwner(String email, String password) {
    currentUserRole = UserRole.ROLE_OWNER;
    widget._stateManager.loginOwner(email, password, this);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.confirmCaptainCode(smsCode, this);
  }

  void retryPhone() {
    _currentStates = LoginStateInit(this);
    if (mounted) setState(() {});
  }

  void setRole(UserRole userType) {
    initRole = userType;
  }
}
