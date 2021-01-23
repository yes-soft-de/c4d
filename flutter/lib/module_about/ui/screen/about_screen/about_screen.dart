import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_init.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class AboutScreen extends StatefulWidget {
  final AboutScreenStateManager _stateManager;

  AboutScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  AboutState _currentState;
  UserRole _currentRole;

  void setLanguage(String lang) => widget._stateManager.setLanguage(lang);

  void setCurrentUser(UserRole role) => _currentRole = role;

  void moveToRegister() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(AuthorizationRoutes.REGISTER_SCREEN);
    });
  }

  @override
  void initState() {
    _currentState = AboutStatePageInit(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _currentState.getUI(context)),
          GestureDetector(
            onTap: () {
              moveToRegister();
            },
            child: Text(
              S.of(context).skip,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
