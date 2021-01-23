
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';

import 'package:flutter/material.dart';

import 'captain_orders_list_state.dart';

class OrdersListStateInit extends CaptainOrdersListState {
  OrdersListStateInit(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Text('Welcome to Orders Screen'),
    );
  }
}
