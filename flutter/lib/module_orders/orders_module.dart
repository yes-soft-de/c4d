import 'package:c4d/abstracts/module/yes_module.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/map/map_screen.dart';
import 'package:c4d/module_orders/ui/screens/new_order/new_order_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status_for_captain/order_status_for_captain_screen.dart';
import 'package:c4d/module_orders/ui/screens/order_status_for_owner/order_status_for_owner.dart';
import 'package:c4d/module_orders/ui/screens/orders/orders_screen.dart';
import 'package:c4d/module_orders/ui/screens/owner_orders/owner_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class OrdersModule extends YesModule{

  final MapScreen _mapScreen;
  final OrdersScreen _ordersScreen;
  final OwnerOrdersScreen _ownerOrdersScreen;
  final NewOrderScreen _newOrderScreen;
  final OrderStatusForCaptainScreen _orderStatusForCaptainScreen;
  final OrderStatusForOwnerScreen _orderStatusForOwnerScreen;

  OrdersModule(
      this._orderStatusForOwnerScreen,
      this._orderStatusForCaptainScreen,
      this._newOrderScreen,
      this._ownerOrdersScreen,
      this._ordersScreen,
      this._mapScreen,
      );
  @override
  Map<String,WidgetBuilder> getRoutes() {
     return{
       OrdersRoutes.MAP_SCREEN : (context) => _mapScreen,
       OrdersRoutes.NEW_ORDER_SCREEN : (context) => _newOrderScreen,
       OrdersRoutes.ORDERS_SCREEN : (context) => _ordersScreen,
       OrdersRoutes.OWNER_ORDERS_SCREEN : (context) => _ownerOrdersScreen,
       OrdersRoutes.ORDER_STATUS_FOR_CAPTAIN_SCREEN : (context) => _orderStatusForCaptainScreen,
       OrdersRoutes.ORDER_STATUS_FOR_OWNER_SCREEN : (context) => _orderStatusForOwnerScreen,
     };
  }

}