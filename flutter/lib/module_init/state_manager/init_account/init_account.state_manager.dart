

import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/service/init_account/init_account.service.dart';
import 'package:c4d/module_init/state/init_account/init_account.state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class InitAccountStateManager {
  final InitAccountService _initAccountService;
  final PublishSubject<InitAccountState> _stateSubject = PublishSubject();

  Stream<InitAccountState> get stateStream => _stateSubject.stream;

  InitAccountStateManager(this._initAccountService,);

  void getPackages() {
    _stateSubject.add(InitAccountFetchingDataState());

    _initAccountService.getPackages().then((value) {
      if (value == null) {
        Fluttertoast.showToast(msg: S.current.errorLoadingData);
        _stateSubject.add(InitAccountFetchingDataErrorState());
      }
      else {
        _stateSubject.add(InitAccountFetchingDataSuccessState(value));
      }
    });
  }
}