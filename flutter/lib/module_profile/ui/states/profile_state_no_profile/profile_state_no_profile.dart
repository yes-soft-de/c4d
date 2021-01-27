import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateNoProfile extends ProfileState {
  ProfileStateNoProfile(EditProfileScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileFormWidget(
      onProfileSaved: (name, phone, image) {
        screenState.saveProfile(name, phone, image);
      },
      onImageUpload: (image, name, phone) {
        screenState.uploadImage(name, phone, image);
      },
    );
  }
}
