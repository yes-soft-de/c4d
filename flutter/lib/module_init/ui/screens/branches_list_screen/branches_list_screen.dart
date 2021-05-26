import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/state_manager/branches_list_state_manager/branches_list_state_manager.dart';
import 'package:c4d/module_init/ui/state/branches_list_state/branches_list_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class BranchesListScreen extends StatefulWidget {
  final BranchesListStateManager _manager;

  const BranchesListScreen(this._manager);
  @override
  BranchesListScreenState createState() => BranchesListScreenState();
}

class BranchesListScreenState extends State<BranchesListScreen> {
  BranchListState currentState;

  @override
  void initState() {
    currentState = BranchListStateLoading(this);
    widget._manager.getBranchesList(this);
    widget._manager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).updateBranches),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(InitAccountRoutes.UPDATE_BRANCH_SCREEN);
              })
        ],
      ),
      body: currentState.getUI(context),
    );
  }
}
