import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/ui/screens/init_captain/init_account_captain_screen.dart';
import 'package:c4d/module_init/ui/state/init_account_captain/init_account_captain.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_init_profile/init_account_captain_init_profile.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_loading/init_account_captain_loading.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountCaptainStateManager {
  final _stateSubject = PublishSubject<InitAccountCaptainState>();

  final ImageUploadService _uploadService;
  final ProfileService _profileService;
  InitAccountCaptainStateManager(this._uploadService, this._profileService);

  void submitProfile(Uri captainImage, Uri licenceImage, String name, String age, InitAccountCaptainScreenState screenState) {
    screenState.showSnackBar(S.current.uploadingImagesPleaseWait);
    _stateSubject.add(InitAccountCaptainStateLoading(screenState, S.current.uploadingImages));
    Future.wait([_uploadService.uploadImage(captainImage.path), _uploadService.uploadImage(licenceImage.path)]).then((value) {
      if (value[0] != null && value[1] != null) {
        _stateSubject.add(InitAccountCaptainStateLoading(screenState, S.current.submittingProfile));
        _profileService.createCaptainProfile(name, age, value[0], value[1]).then((value) {
          if (value != null) {

          }
        });
      } else {
        screenState.showSnackBar(S.current.errorUploadingImages);
        _stateSubject.add(InitAccountCaptainInitProfile.withData(screenState, captainImage, licenceImage, name, age));
      }
    });
  }
}