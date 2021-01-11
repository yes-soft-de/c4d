import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_init/ui/state/init_account/init_account.state.dart';
import 'package:c4d/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final ProfileService _profileService;
  final PublishSubject<InitAccountState> _stateSubject =
      PublishSubject<InitAccountState>();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(
    this._initAccountService,
    this._profileService,
  );

  void subscribePackage(int packageId, InitAccountScreenState screen) {
    _stateSubject.add(
      InitAccountStateLoading(screen),
    );
    _initAccountService.subscribePackage(packageId).then((value) {
      if (value) {
        _stateSubject.add(
          InitAccountStateSubscribeSuccess(screen),
        );
      } else {
        Fluttertoast.showToast(msg: S.current.errorHappened);
        _stateSubject.add(
          InitAccountStateError(S.current.errorHappened, screen),
        );
      }
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
}
