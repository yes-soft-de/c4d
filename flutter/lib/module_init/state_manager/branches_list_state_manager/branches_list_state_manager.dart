import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/service/branches_list/branches_list_service.dart';
import 'package:c4d/module_init/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_init/ui/state/branches_list_state/branches_list_state.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class BranchesListStateManager {
  final BranchesListService _branchesListService;

  final PublishSubject<BranchListState> _stateSubject =
      PublishSubject<BranchListState>();

  Stream<BranchListState> get stateStream => _stateSubject.stream;

  BranchesListStateManager(
    this._branchesListService,
  );
  void getBranchesList(BranchesListScreenState state) {
    _stateSubject.add(BranchListStateLoading(state));
    _branchesListService.getBranches().then((value) {
      if (value != null) {
        _stateSubject.add(BranchListStateLoaded(value, state));
      } else {
        _stateSubject.add(BranchListStateError('Error fetching data', state));
      }
    });
  }
}
