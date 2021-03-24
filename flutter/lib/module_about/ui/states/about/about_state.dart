import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:flutter/material.dart';

abstract class AboutState {
  AboutScreenStateManager screenState;
  AboutState(this.screenState);

  Widget getUI(BuildContext context);
}