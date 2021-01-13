import 'package:c4d/module_orders/state_manager/order_status/order_status.state_manager.dart';
import 'package:c4d/module_orders/ui/state/order_status/order_status.state.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusScreen extends StatefulWidget {
  final OrderStatusStateManager _stateManager;

  OrderStatusScreen(
    this._stateManager,
  );

  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  String orderId;
  OrderDetailsState currentState;

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
    });

    super.initState();
    orderId = ModalRoute.of(context).settings.arguments;
    widget._stateManager.getOrderDetails(orderId, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState.getUI(context),
    );
  }
}
