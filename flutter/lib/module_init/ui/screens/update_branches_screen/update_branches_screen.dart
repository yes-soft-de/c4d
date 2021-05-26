import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/init_routes.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/state_manager/update_branches_state_manager/update_branches_state_manager.dart';
import 'package:c4d/module_init/ui/state/update_branches_state/update_branches_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class UpdateBranchScreen extends StatefulWidget {
  final UpdateBranchStateManager _manager;

  UpdateBranchScreen(this._manager);

  @override
  UpdateBranchScreenState createState() => UpdateBranchScreenState();
}

class UpdateBranchScreenState extends State<UpdateBranchScreen> {
  UpdateBranchState currentState;

  @override
  void initState() {
    currentState = UpdateBranchStateLoaded(this);
    super.initState();
  }

  void updateBranch(UpdateBranchesRequest request) {
    widget._manager.UpdateBranch(this, request);
  }

  void moveNext(bool success) {
    if (success) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(InitAccountRoutes.BRANCHES_LIST_SCREEN);
      Flushbar(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchSuccess,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      Navigator.of(context).pop();
      Flushbar(
        title: S.of(context).updateBranch,
        message: S.of(context).updateBranchFailure,
        icon: Icon(
          Icons.info,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).updateBranch),
      ),
      body: currentState.getUI(context),
    );
  }
}
