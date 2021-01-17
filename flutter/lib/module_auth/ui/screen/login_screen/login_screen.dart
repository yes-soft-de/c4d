import 'dart:async';

import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/state_manager/login_state_manager/login_state_manager.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
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

@provide
class LoginScreenState extends State<LoginScreen> {
  UserRole currentUserRole;

  LoginState _currentState;

  StreamSubscription _stateSubscription;
  bool deepLinkChecked = false;

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentState = LoginStateInit(this);
    widget._stateManager.stateStream.listen((event) {
      setState(() {
        _currentState = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  void navigateToOrders() {
    if (currentUserRole == UserRole.ROLE_CAPTAIN) {
      Navigator.of(context).pushNamed(OrdersRoutes.CAPTAIN_ORDERS_SCREEN);
    } else if (currentUserRole == UserRole.ROLE_OWNER) {
      Navigator.of(context).pushNamed(OrdersRoutes.CAPTAIN_ORDERS_SCREEN);
    }
  }

  void loginCaptain(String phoneNumber) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.loginCaptain(phoneNumber);
  }

  void loginOwner(String email, String username, String password) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.loginOwner(email, username, password);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.loginCaptain(smsCode);
  }

  void retryPhone() {
    _currentState = LoginStateInit(this);
  }
}
