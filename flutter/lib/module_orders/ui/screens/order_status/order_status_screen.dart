import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
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
  int orderId;
  OrderDetailsState currentState;

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void requestOrderProgress(OrderModel currentOrder) {
    OrderStatus newStatus;
    switch (currentOrder.status) {
      case OrderStatus.INIT:
        newStatus = OrderStatus.GOT_CAPTAIN;
        break;
      case OrderStatus.GOT_CAPTAIN:
        newStatus = OrderStatus.IN_STORE;
        break;
      case OrderStatus.IN_STORE:
        newStatus = OrderStatus.DELIVERING;
        break;
      case OrderStatus.DELIVERING:
        newStatus = currentOrder.paymentMethod == 'CASH'
            ? OrderStatus.GOT_CAPTAIN
            : OrderStatus.FINISHED;
        break;
      case OrderStatus.GOT_CASH:
        newStatus = OrderStatus.FINISHED;
        break;
      case OrderStatus.FINISHED:
        break;
    }

    currentOrder.status = newStatus;
    widget._stateManager.updateOrder(currentOrder, this);
  }

  @override
  Widget build(BuildContext context) {
    if (currentState == null) {
      orderId = ModalRoute.of(context).settings.arguments;
      widget._stateManager.getOrderDetails(orderId, this);
      currentState = OrderDetailsStateInit(this);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(S.of(context).orderDetails),
      ),
      body: currentState.getUI(context),
    );
  }
}
