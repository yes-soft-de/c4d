import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/model/branches/branches_model.dart';
import 'package:c4d/module_init/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:flutter/material.dart';

abstract class BranchListState {
  final BranchesListScreenState screenState;

  BranchListState(this.screenState);

  Widget getUI(BuildContext context);
}

class BranchListStateLoading extends BranchListState {
  BranchListStateLoading(BranchesListScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class BranchListStateError extends BranchListState {
  String errorMsg;

  BranchListStateError(
    this.errorMsg,
    BranchesListScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}

class BranchListStateLoaded extends BranchListState {
  List<BranchesModel> branches;
  BranchListStateLoaded(
    this.branches,
    BranchesListScreenState screenState,
  ) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return branches.isNotEmpty
        ? ListView.builder(
            itemCount: branches.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, InitAccountRoutes.UPDATE_BRANCH_SCREEN,
                          arguments: branches[index]);
                    },
                    tileColor: Theme.of(context).primaryColor,
                    leading: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                    title: Text(
                      branches[index].branchName??'',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: Text('Empty List'),
          );
  }
}
