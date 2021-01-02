

import 'package:c4d/module_orders/repository/new_order/new_order.repository.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:inject/inject.dart';

@provide
class NewOrderManager{
  final NewOrderRepository _repository;

  NewOrderManager(
      this._repository,
      );

  Future<bool> addNewOrder(OrderRequest orderRequest)async => await _repository.addNewOrder(orderRequest);
}