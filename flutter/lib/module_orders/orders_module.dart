import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/map/map_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status/order_status_screen.dart';
import 'package:c4d/module_orders/ui/screens/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersModule extends YesModule {
  final OrdersScreen _ordersScreen;
  final NewOrderScreen _newOrderScreen;
  final OrderStatusScreen _orderStatus;

  OrdersModule(
    this._newOrderScreen,
    this._orderStatus,
    this._ordersScreen,
  );

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      OrdersRoutes.NEW_ORDER_SCREEN: (context) => _newOrderScreen,
      OrdersRoutes.ORDERS_SCREEN: (context) => _ordersScreen,
      OrdersRoutes.ORDER_STATUS: (context) => _orderStatus,
    };
  }
}
