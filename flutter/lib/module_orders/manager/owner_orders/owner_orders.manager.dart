


import 'package:c4d/module_orders/repository/owner_orders/owner_orders.repository.dart';
import 'package:c4d/module_orders/response/owner_orders/owner_orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OwnerOrdersManager{
  final OwnerOrdersRepository _repository;

  OwnerOrdersManager(
      this._repository,
      );

  Future<OwnerOrdersResponse> getNearbyOrders()async {
    return await _repository.getOwnerOrders();
  }

}