import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateGotProfile extends ProfileState {
  ProfileRequest request;

  ProfileStateGotProfile(
      EditProfileScreenState screenState, this.request)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      child: ProfileFormWidget(
        isCaptain: true,
        onProfileSaved: (profile) {
          request.name = profile.name;
          request.phone = profile.phone;
          request.stcPay = profile.stcPay;
          request.bankAccountNumber = profile.bankNumber;
          request.bankName = profile.bankName;
          request.image = profile.image;
          screenState.saveProfile(request);
        },
        onImageUpload: (profile) {
          request.name = profile.name;
          request.phone = profile.phone;
          request.stcPay = profile.stcPay;
          request.bankAccountNumber = profile.bankNumber;
          request.bankName = profile.bankName;
          request.image = profile.image;
          screenState.uploadImage(request);
        },
        request: request,
      ),
    );
  }
}
