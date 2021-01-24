import 'package:c4d/module_init/ui/screens/init_captain/init_account_captain_screen.dart';
import 'package:flutter/material.dart';

abstract class InitAccountCaptainState {
  final InitAccountCaptainScreenState screenState;
  InitAccountCaptainState(this.screenState);

  Widget getUI(BuildContext context);
}