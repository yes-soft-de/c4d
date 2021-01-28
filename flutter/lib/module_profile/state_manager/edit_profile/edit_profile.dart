import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_no_profile/profile_state_no_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_success/profile_state_success.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditProfileStateManager {
  final _stateSubject = PublishSubject<ProfileState>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;

  EditProfileStateManager(this._imageUploadService, this._profileService);

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void uploadImage(EditProfileScreenState screenState, String image,
      String name, String phone) {
    _imageUploadService.uploadImage(image).then((uploadedImageLink) {
      _stateSubject.add(ProfileStateDirtyProfile(
          screenState, name, phone, uploadedImageLink));
    });
  }

  void submitProfile(EditProfileScreenState screenState, String name,
      String phone, String image) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.createProfile(name, phone, image).then((value) {
      if (value) {
        _stateSubject.add(ProfileStateSaveSuccess(screenState));
      } else {
        _stateSubject
            .add(ProfileStateGotProfile(screenState, name, phone, image));
      }
    });
  }

  void getProfile(EditProfileScreenState screenState) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _profileService.getProfile().then((value) {
      if (value == null) {
        _stateSubject.add(ProfileStateNoProfile(screenState));
      } else {
        _stateSubject.add(ProfileStateGotProfile(
          screenState,
          value.name,
          value.phone,
          value.image,
        ));
      }
    });
  }
}
