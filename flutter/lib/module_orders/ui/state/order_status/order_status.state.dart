import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:flutter/material.dart';

abstract class OrderDetailsState {
  final OrderStatusScreenState screenState;

  OrderDetailsState(this.screenState);

  Widget getUI(BuildContext context);
}

class OrderDetailsStateLoading extends OrderDetailsState {
  OrderDetailsStateLoading(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrderDetailsStateInit extends OrderDetailsState {
  OrderDetailsStateInit(OrderStatusScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class OrderDetailsStateError extends OrderDetailsState {
  String errorMsg;

  OrderDetailsStateError(
    this.errorMsg,
    OrderStatusScreenState screenState,
  ) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('${errorMsg}'),
    );
  }
}
