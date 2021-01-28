import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:c4d/module_about/ui/states/about/about_state_booking_success.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_captain.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_init.dart';
import 'package:c4d/module_about/ui/states/about/about_state_page_owner.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void setLanguage(String lang) => widget._stateManager.setLanguage(lang);

  void showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  void setCurrentUser(UserRole role) => _currentRole = role;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void moveToRegister() {
    Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
  }

  void moveNext(UserRole role) {
    if (role == UserRole.ROLE_OWNER) {
      _currentState = AboutStatePageOwner(this);
    } else {
      _currentState = AboutStatePageCaptain(this);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void setBookingSuccess() {
    _currentState = AboutStatePageOwnerBookingSuccess(this);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _currentState = AboutStatePageInit(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
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
      ),
    );
  }
}
