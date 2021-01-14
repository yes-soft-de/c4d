import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:c4d/module_orders/response/owner_orders/owner_orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OrderRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  OrderRepository(
    this._apiClient,
    this._authService,
  );

  Future<bool> addNewOrder(CreateOrderRequest orderRequest) async {
    var token = await _authService.getAuthHeaderMap();
    dynamic response = await _apiClient.post(
      Urls.NEW_ORDER,
      orderRequest.toJson(),
      headers: token,
    );

    if (response == null) return false;

    return response['status_code'] == '201' ? true : false;
  }

  Future<OrderStatusResponse> getOrderDetails(int orderId) async {
    if (orderId == null) {
      return null;
    }
    var token = await _authService.getAuthHeaderMap();
    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS + '$orderId',
      headers: token,
    );
    if (response == null) return null;
    return OrderStatusResponse.fromJson(response['Data']);
  }

  Future<List<Order>> getNearbyOrders() async {
    var token = await _authService.getAuthHeaderMap();

    dynamic response = await _apiClient.get(
      Urls.NEARBY_ORDERS,
      headers: token,
    );
    if (response == null) return null;

    return OrdersResponse.fromJson(response).data;
  }

  Future<List<Order>> getMyOrders() async {
    var token = await _authService.getAuthHeaderMap();

    dynamic response = await _apiClient.get(
      Urls.OWNER_ORDERS,
      headers: token,
    );
    if (response == null) return [];

    return OrdersResponse.fromJson(response).data;
  }

}
