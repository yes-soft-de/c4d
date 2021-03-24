import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_init.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  final AboutScreenStateManager _stateManager;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AboutScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => _AboutScreenState();

  void moveToRegister() {
    Navigator.of(_scaffoldKey.currentContext)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
  }

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}

class _AboutScreenState extends State<AboutScreen> {
  AboutState _currentState;
  AboutStatePageOwner _pageOwner;
  int currentPage = 0;
  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (_currentState is AboutStatePageOwner) {
        _pageOwner = _currentState;
      }
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageOwner != null) {
      currentPage = _pageOwner.getCurrentPage;
    }
    return Scaffold(
      key: widget._scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: _currentState != null
                  ? _currentState.getUI(context)
                  : AboutStatePageInit(widget._stateManager).getUI(context)),
          _currentState is AboutStatePageOwner && currentPage != 3
              ? Container()
              : GestureDetector(
                  onTap: () {
                    widget.moveToRegister();
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
      ),
    );
  }
}
