import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';

abstract class ProfileState {
  final EditProfileScreenState screenState;
  ProfileState(this.screenState);

  Widget getUI(BuildContext context);
}