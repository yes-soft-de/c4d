import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final AboutScreenStateManager _stateManager;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AboutScreen(this._stateManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
        stream: _stateManager.stateStream,
        initialData: _stateManager.initialState(this),
        builder: (BuildContext context, AsyncSnapshot<AboutState> snapshot) {
          final _currentState = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _currentState.getUI(context)),
              GestureDetector(
                onTap: () {
                  moveToRegister();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    S.of(context).skip,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void moveToRegister() {
    Navigator.of(_scaffoldKey.currentContext).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
