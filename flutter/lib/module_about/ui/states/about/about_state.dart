import 'package:c4d/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:flutter/material.dart';

abstract class AboutState {
  AboutState(AboutScreenState screenState);

  Widget getUI(BuildContext context);
}