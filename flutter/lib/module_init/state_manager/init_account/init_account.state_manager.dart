import 'package:c4d/consts/branch.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_init/ui/state/init_account_branch_saved/init_account_state_payment.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_init_profile/init_account_captain_init_profile.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_loading/init_account_captain_loading.dart';
import 'package:c4d/module_init/ui/state/init_account_captain_profile_created/init_account_captain_profile_created.dart';
import 'package:c4d/module_init/ui/state/init_account_packages_loaded/init_account_packages_loaded.dart';
import 'package:c4d/module_init/ui/state/init_account_subscription_added/init_account_state_select_branch.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:latlong/latlong.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<InitAccountState> _stateSubject =
      PublishSubject<InitAccountState>();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
    this._profileService,
    this._authService,
    this._uploadService,
  );

  void getRoleInit(InitAccountScreenState screen) {
    _authService.userRole.then((value) {
      if (value == UserRole.ROLE_OWNER) {
        getPackages(screen);
      } else {
        getCaptainScreen(screen);
      }
    });
  }

  void submitProfile(Uri captainImage, Uri licenceImage, String name,
      String age, InitAccountScreenState screenState) {
    screenState.showSnackBar(S.current.uploadingImagesPleaseWait);
    _stateSubject.add(
        InitAccountCaptainStateLoading(screenState, S.current.uploadingImages));
    Future.wait([
      _uploadService.uploadImage(captainImage.path),
      _uploadService.uploadImage(licenceImage.path)
    ]).then((value) {
      if (value[0] != null && value[1] != null) {
        _stateSubject.add(InitAccountCaptainStateLoading(
            screenState, S.current.submittingProfile));
        _initAccountService
            .createCaptainProfile(name, age, value[0], value[1])
            .then((value) {
          _stateSubject.add(InitAccountStateProfileCreated(screenState));
        });
      } else {
        screenState.showSnackBar(S.current.errorUploadingImages);
        _stateSubject.add(InitAccountCaptainInitProfile.withData(
            screenState, captainImage, licenceImage, name, age));
      }
    });
  }

  void submitAccountNumber(String bankName, String bankAccountNumber,
      InitAccountScreenState screenState) {
    _stateSubject.add(
      InitAccountStateLoading(screenState),
    );
    _initAccountService
        .createBankDetails(bankName, bankAccountNumber)
        .then((value) {
      screenState.moveToOrders();
    });
  }

  void getCaptainScreen(InitAccountScreenState screenState) {
    _stateSubject.add(InitAccountCaptainInitProfile(screenState));
  }

  void subscribePackage(InitAccountScreenState screen, int packageId, String name, String phone, String city) {
    _stateSubject.add(
      InitAccountStateLoading(screen),
    );
    Future.wait([_profileService.createProfile(ProfileRequest(
      name: name,
      phone: phone,
      city: city,
      age: 30.toString(),
      image: 'https://orthosera-dental.com/wp-content/uploads/2016/02/user-profile-placeholder.png',
    )),_initAccountService.subscribePackage(packageId)] )
    .then((value) {
      _stateSubject.add(
        InitAccountStateSelectBranch(screen),
      );
    });
  }

  void getPackages(InitAccountScreenState screen) {
    _stateSubject.add(InitAccountStateLoading(screen));

    _initAccountService.getPackages().then((value) {
      if (value == null) {
        _stateSubject
            .add(InitAccountStateError('Error Fetching Packages', screen));
      } else {
        _stateSubject.add(InitAccountStatePackagesLoaded(value, screen));
      }
    });
  }

  void saveBranch(List<LatLng> position, InitAccountScreenState screen) {
    _stateSubject.add(InitAccountStateLoading(screen));

    var branches = <Branch>[];
    for (int i = 0; i < position.length; i++) {
      branches.add(Branch(
          brancheName: '${i + 1}',
          location: Location(
            lat: position[i].latitude,
            lon: position[i].longitude,
          )));
    }

    _profileService.saveBranch(branches).then((value) {
      if (value == null) {
        _stateSubject.add(InitAccountStateError(
          'Error Saving Branch',
          screen,
        ));
      } else {
        _stateSubject.add(
          InitAccountStatePayment(screen),
        );
      }
    });
  }
}
