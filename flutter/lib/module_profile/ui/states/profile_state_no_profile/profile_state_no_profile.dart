import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateNoProfile extends ProfileState {
  ProfileRequest request;
  final bool isCaptain;
  ProfileStateNoProfile(
      EditProfileScreenState screenState, this.request, this.isCaptain)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    request ??= ProfileRequest.empty();
    return SingleChildScrollView(
      child: ProfileFormWidget(
        onProfileSaved: (profile) {
          request.name = profile.name;
          request.phone = profile.phone;
          request.stcPay = profile.stcPay;
          request.bankAccountNumber = profile.bankNumber;
          request.bankName = profile.bankName;
          request.image = profile.image;
          request.city = profile.city;
          screenState.saveProfile(request);
        },
        onImageUpload: (profile, type, image) {
          request.name = profile.name;
          request.phone = profile.phone;
          request.stcPay = profile.stcPay;
          request.bankAccountNumber = profile.bankNumber;
          request.bankName = profile.bankName;
          request.image = profile.image;
          request.city = profile.city;
          screenState.uploadImage(request, type, image);
        },
        isCaptain: isCaptain,
      ),
    );
  }
}
