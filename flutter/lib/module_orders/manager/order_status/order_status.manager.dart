
import 'package:c4d/module_orders/repository/order_status/order_status.repository.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusManager{
  final OrderStatusRepository _repository;

  OrderStatusManager(
      this._repository,
      );

  Future<OrderStatusResponse> getOrderDetails(int oderId)async{
    return await _repository.getOrderDetails(oderId);
  }
}