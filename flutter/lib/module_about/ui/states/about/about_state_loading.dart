import 'package:c4d/module_about/state_manager/about_screen_state_manager.dart';
import 'package:c4d/module_about/ui/states/about/about_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutStateLoading extends AboutState {
  AboutStateLoading(AboutScreenStateManager screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
