import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_init/state/init_account/init_account.state.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final ProfileService _profileService;
  final PublishSubject<InitAccountState> _stateSubject = PublishSubject();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
    this._profileService,
  );

  void createProfile(String city, int branch) {
    _profileService.createProfile(city, branch).then((value) {
      if (value) {
        _stateSubject.add(InitAccountCreateProfileSuccessState());
      } else {
        Fluttertoast.showToast(msg: 'Error Happened');
        _stateSubject.add(InitAccountCreateProfileErrorState());
      }
    });
  }

  void subscribePackage(int packageId) {
    _initAccountService.subscribePackage(packageId).then((value) {
      if (value) {
        _stateSubject.add(InitAccountSubscribeSuccessState());
      } else {
        Fluttertoast.showToast(msg: S.current.errorHappened);
        _stateSubject.add(InitAccountSubscribeErrorState());
      }
    });
  }

  void getPackages() {
    _stateSubject.add(InitAccountFetchingDataState());

    _initAccountService.getPackages().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: 'Error Loading Data');
        _stateSubject.add(InitAccountFetchingDataErrorState());
      } else {
        _stateSubject.add(InitAccountFetchingDataSuccessState(value));
      }
    });
  }
}
