import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_profile/ui/screen/edit_profile/edit_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_loading/profile_loading.dart';
import 'package:c4d/module_profile/ui/states/profile_state/profile_state.dart';
import 'package:c4d/module_profile/ui/states/profile_state_dirty_profile/profile_state_dirty_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_got_profile/profile_state_got_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_no_profile/profile_state_no_profile.dart';
import 'package:c4d/module_profile/ui/states/profile_state_success/profile_state_success.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class EditProfileStateManager {
  final _stateSubject = PublishSubject<ProfileState>();
  final ImageUploadService _imageUploadService;
  final ProfileService _profileService;
  final AuthService _authService;

  EditProfileStateManager(
    this._imageUploadService,
    this._profileService,
    this._authService,
  );

  Stream<ProfileState> get stateStream => _stateSubject.stream;

  void uploadImage(
      EditProfileScreenState screenState, ProfileRequest request, String type,
      [String image]) {
    _authService.userRole.then((role) {
      _imageUploadService
          .uploadImage(image ?? request.image)
          .then((uploadedImageLink) {
        if (type == 'identity') {
          request.identity = uploadedImageLink;
        } else if (type == 'mechanic') {
          request.mechanicLicense = uploadedImageLink;
        } else if (type == 'driving') {
          request.drivingLicence = uploadedImageLink;
        } else {
          request.image = uploadedImageLink;
        }
        _stateSubject.add(ProfileStateDirtyProfile(
          screenState,
          request,
          role == UserRole.ROLE_CAPTAIN,
        ));
      });
    });
  }

  void submitProfile(
      EditProfileScreenState screenState, ProfileRequest request) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _authService.userRole.then((role) {
      _profileService.createProfile(request).then((value) {
        if (value) {
          _stateSubject.add(ProfileStateSaveSuccess(
            screenState,
            role == UserRole.ROLE_CAPTAIN,
          ));
        } else {
          _stateSubject.add(ProfileStateGotProfile(
            screenState,
            request,
            role == UserRole.ROLE_CAPTAIN,
          ));
        }
      });
    });
  }

  void getProfile(EditProfileScreenState screenState) {
    _stateSubject.add(ProfileStateLoading(screenState));
    _authService.userRole.then((role) {
      _profileService.getProfile().then((value) {
        if (value == null) {
          _stateSubject.add(ProfileStateNoProfile(
              screenState, ProfileRequest(), role == UserRole.ROLE_CAPTAIN));
        } else {
          _stateSubject.add(ProfileStateGotProfile(
            screenState,
            ProfileRequest(
                name: value.name,
                image: value.image,
                phone: value.phone,
                drivingLicence: value.drivingLicence,
                city: value.city,
                branch: '-1',
                bankName: value.bankName,
                bankAccountNumber: value.accountID,
                stcPay: value.stcPay,
                car: value.car,
                age: value.age.toString(),
                mechanicLicense: value.mechanicLicense,
                identity: value.identity),
            role == UserRole.ROLE_CAPTAIN,
          ));
        }
      });
    });
  }
}
