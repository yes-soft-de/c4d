import 'package:c4d/module_profile/ui/screen/profile_screen/profile_screen..dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateLoading extends ProfileState {
  ProfileStateLoading(ProfileScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
