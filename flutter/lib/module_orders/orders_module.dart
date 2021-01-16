import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders/owner_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersModule extends YesModule {
  final OwnerOrdersScreen _ordersScreen;
  final NewOrderScreen _newOrderScreen;
  final OrderStatusScreen _orderStatus;
  final CaptainOrdersScreen _captainOrdersScreen;

  OrdersModule(
    this._newOrderScreen,
    this._orderStatus,
    this._ordersScreen,
    this._captainOrdersScreen,
  ) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => _newOrderScreen,
      OrdersRoutes.OWNER_ORDERS_SCREEN: (context) => _ordersScreen,
      OrdersRoutes.ORDER_STATUS_SCREEN: (context) => _orderStatus,
      OrdersRoutes.CAPTAIN_ORDERS_SCREEN: (context) => _captainOrdersScreen,
    };
  }
}
