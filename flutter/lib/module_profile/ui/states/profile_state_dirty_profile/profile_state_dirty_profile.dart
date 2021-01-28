import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateDirtyProfile extends ProfileState {
  final String name;
  final String phone;
  final String image;

  ProfileStateDirtyProfile(
      EditProfileScreenState screenState, this.name, this.phone, this.image)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileFormWidget(
      name: name,
      phoneNumber: phone,
      image: image,
      onProfileSaved: (name, phone, image) {
        screenState.saveProfile(name, phone, image);
      },
      onImageUpload: (name, phone, localImage) {
        screenState.uploadImage(name, phone, localImage);
      },
    );
  }
}
