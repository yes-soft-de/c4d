import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/service/branches_list/branches_list_service.dart';
import 'package:c4d/module_init/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:c4d/module_init/ui/state/update_branches_state/update_branches_state.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class UpdateBranchStateManager {
  final BranchesListService _branchesListService;
  UpdateBranchStateManager(this._branchesListService);
  final PublishSubject<UpdateBranchState> _stateSubject =
      PublishSubject<UpdateBranchState>();

  Stream<UpdateBranchState> get stateStream => _stateSubject.stream;

  void UpdateBranch(
      UpdateBranchScreenState state, UpdateBranchesRequest request) {
    _stateSubject.add(UpdateBranchStateLoading(state));
    _branchesListService.updateBranch(request).then((value) {
      if (value) {
        state.moveNext(value);
      } else {
        _stateSubject.add(UpdateBranchStateLoaded(state));
        state.moveNext(value);
      }
    });
  }
}
