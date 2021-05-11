import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/state_manager/plan_screen_state_manager.dart';
import 'package:c4d/module_plan/ui/state/plan_state.dart';
import 'package:c4d/module_plan/ui/state/plan_state_loading.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class PlanScreen extends StatefulWidget {
  final PlanScreenStateManager _manager;

  PlanScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  PlanState _currentState;

  @override
  void initState() {
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    widget._manager.getActivePlan(this);
    super.initState();
  }

  void renewPackage(int packageId)  {
     widget._manager.renewPackage(packageId,this);
  }

  @override
  Widget build(BuildContext context) {
    _currentState ??= PlanScreenStateLoading(this);
    return Scaffold(
      body: _currentState.getUI(context) ?? Container(),
    );
  }
}
