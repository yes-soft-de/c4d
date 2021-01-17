import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/state_manager/register_state_manager/register_state_manager.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_init.dart';
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

  @override
  void initState() {
    super.initState();

    widget._stateManager.stateStream.listen((event) {
      if (this.mounted) {
        setState(() {
          _currentState = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState.getUI(context),
    );
  }


  void registerCaptain(String phoneNumber) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.registerCaptain(phoneNumber);
  }

  void registerOwner(String email, String username, String password) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.registerOwner(email, username, password);
  }

  void confirmCaptainSMS(String smsCode) {
    currentUserRole = UserRole.ROLE_CAPTAIN;
    widget._stateManager.registerCaptain(smsCode);
  }

  void retryPhone() {
    _currentState = RegisterStateInit(this);
  }
}
