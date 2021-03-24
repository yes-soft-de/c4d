import 'dart:async';

import 'package:c4d/module_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/update/update_state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class UpdateScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  UpdateScreen(
    this._stateManager,
  );

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  StreamSubscription _updateSubscription;
  UpdateListState currenState;
  @override
  void initState() {
    super.initState();
    _updateSubscription = widget._stateManager.updateStram.listen((event) {
      currenState = event;
      setState(() {});
    });
    widget._stateManager.getUpdates(this);
  }

  @override
  Widget build(BuildContext context) {
    return currenState != null
        ? currenState.getUI(context)
        : UpdateListStateLoading(this).getUI(context);
  }

  @override
  void dispose() {
    if (_updateSubscription != null) {
      _updateSubscription.cancel();
    }
    super.dispose();
  }
}
