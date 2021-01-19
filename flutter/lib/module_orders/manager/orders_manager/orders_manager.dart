import 'package:c4d/module_orders/repository/order_repository/order_repository.dart';
import 'package:c4d/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OrdersManager {
  final OrderRepository _repository;

  OrdersManager(
    this._repository,
  );

  Future<bool> addNewOrder(CreateOrderRequest orderRequest) =>
      _repository.addNewOrder(orderRequest);

  Future<OrderDetailsData> getOrderDetails(int orderId) =>
      _repository.getOrderDetails(orderId);

  Future<List<Order>> getNearbyOrders() => _repository.getNearbyOrders();

  Future<List<Order>> getMyOrders() => _repository.getMyOrders();

  Future<OrderDetailsResponse> acceptOrder(AcceptOrderRequest acceptOrderRequest) => _repository.acceptOrder(acceptOrderRequest);

  Future<OrderDetailsResponse> updateOrder(UpdateOrderRequest acceptOrderRequest) => _repository.updateOrder(acceptOrderRequest);
}
