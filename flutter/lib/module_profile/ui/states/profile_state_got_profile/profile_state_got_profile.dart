import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/widget/profile_form/profile_form.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileStateGotProfile extends ProfileState {
  String name;
  String phone;
  String image;

  ProfileStateGotProfile(
      EditProfileScreenState screenState, this.name, this.phone, this.image)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ProfileFormWidget(
      onProfileSaved: (name, phone, image) {
        screenState.saveProfile(name, phone, image);
      },
      onImageUpload: (name, phone, image) {
        screenState.uploadImage(name, phone, image);
      },
      name: name,
      phoneNumber: phone,
      image: image,
    );
  }
}
