

import 'package:c4d/module_orders/repository/orders/orders.repository.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OrdersManager{
  final OrdersRepository _repository;

  OrdersManager(
      this._repository,
      );

  Future<OrdersResponse> getNearbyOrders()async {
    return await _repository.getNearbyOrders();
  }

}