import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';

abstract class EditProfileState {
  EditProfileScreenState screenState;
  EditProfileState(this.screenState);

  Widget getUI(BuildContext context);
}

class EditProfileStateInit extends EditProfileState {
  EditProfileStateInit(EditProfileScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold();
  }
}