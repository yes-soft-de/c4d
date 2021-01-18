import 'package:c4d/module_profile/ui/screen/profile_screen/profile_screen..dart';
import 'package:flutter/material.dart';

abstract class ProfileState {
  final ProfileScreenState screen;
  ProfileState(this.screen);

  Widget getUI(BuildContext context);
}