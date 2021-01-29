import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateNoProfile extends ProfileState {
  ProfileRequest request;
  ProfileStateNoProfile(EditProfileScreenState screenState, this.request)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileFormWidget(
      onProfileSaved: (name, phone, image) {
        request.name = name;
        request.phone = phone;
        request.image = image;
        screenState.saveProfile(request);
      },
      onImageUpload: (name, phone, localImage) {
        request.name = name;
        request.phone = phone;
        request.image = localImage;
        screenState.uploadImage(request);
      },
    );
  }
}
