import 'package:c4d/module_init/state_manager/init_account_captain/init_account_captain.dart';
import 'package:flutter/material.dart';

class InitAccountCaptainScreen extends StatefulWidget {
  final InitAccountCaptainStateManager _stateManager;
  InitAccountCaptainScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => InitAccountCaptainScreenState();
}

class InitAccountCaptainScreenState extends State<InitAccountCaptainScreen> {
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void showSnackBar(String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void submitProfile(Uri captainImage, Uri licence, String name, String age) {
    widget._stateManager.submitProfile(captainImage, licence, name, age, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
