import 'dart:async';

import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class RegisterScreen extends StatefulWidget {
  final RegisterStateManager _stateManager;

  RegisterScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterState _currentState;
  UserRole currentUserRole;
  UserRole initRole;
  UserRole get getInitRole => this.initRole;
  AsyncSnapshot loadingSnapshot = AsyncSnapshot.nothing();
  StreamSubscription _stateSubscription;

  StreamSubscription _loadingSubscription;
  @override
  void initState() {
    super.initState();

    _currentState = RegisterStateInit(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
    _loadingSubscription = widget._stateManager.loadingStream.listen((event) {
      loadingSnapshot = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: _currentState.getUI(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _loadingSubscription.cancel();
    super.dispose();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void registerCaptain(String username, String name, String password) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.registerClient(
        RegisterRequest(userID: username, userName: name, password: password),
        currentUserRole,
        this);
  }

  void registerOwner(String username, String name, String password) {
    currentUserRole = UserRole.ROLE_OWNER;
    widget._stateManager.registerClient(
        RegisterRequest(userID: username, userName: name, password: password),
        currentUserRole,
        this);
  }

  void moveToNext() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        InitAccountRoutes.INIT_ACCOUNT_SCREEN, (r) => false);
  }

  void setRole(UserRole userType) {
    initRole = userType;
  }
}
