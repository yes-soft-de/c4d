import 'package:c4d/module_orders/state_manager/orders/orders.state_manager.dart';
import 'package:c4d/module_orders/ui/state/orders/orders.state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersScreen extends StatefulWidget {
  final OrdersStateManager _stateManager;

  OrdersScreen(this._stateManager,);

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  OrdersListState _currentState;

  void getMyOrders() {
    widget._stateManager.getMyOrders(this);
  }

  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      if (mounted) {
        setState(() {
        });
      }
    });
    widget._stateManager.getMyOrders(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentState.getUI(context),
    );
  }
}
