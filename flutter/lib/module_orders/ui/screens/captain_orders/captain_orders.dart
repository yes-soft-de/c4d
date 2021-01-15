import 'package:c4d/module_orders/state_manager/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class CaptainOrdersScreen extends StatefulWidget {
  final CaptainOrdersListStateManager _stateManager;

  CaptainOrdersScreen(this._stateManager);

  @override
  State<StatefulWidget> createState() => CaptainOrdersScreenState();
}

class CaptainOrdersScreenState extends State<CaptainOrdersScreen> {
  CaptainOrdersListState currentState;

  void getMyOrders() {
    widget._stateManager.getMyOrders(this);
  }

  @override
  void initState() {
    super.initState();
    currentState = CaptainOrdersListStateLoading(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState.getUI(context),
    );
  }
}
