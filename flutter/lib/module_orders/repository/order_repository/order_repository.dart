import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/order_details/order_details_response.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
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
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.NEW_ORDER,
      orderRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return false;

    return response['status_code'] == '201' ? true : false;
  }

  Future<OrderDetailsData> getOrderDetails(int orderId) async {
    if (orderId == null) {
      return null;
    }
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS + '$orderId',
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response == null) return null;
    return OrderStatusResponse.fromJson(response).data;
  }

  Future<List<Order>> getNearbyOrders() async {
    var token = await _authService.getToken();

    if (token == null) {
      throw UnauthorizedException('User Not Logged In');
    }

    dynamic response = await _apiClient.get(
      Urls.NEARBY_ORDERS,
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response == null) return null;

    var list = OrdersResponse.fromJson(response).data;
    return list;
  }

  Future<List<Order>> getMyOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.OWNER_ORDERS,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return [];

    return OrdersResponse.fromJson(response).data;
  }

  Future<OrderDetailsResponse> acceptOrder(AcceptOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      '${Urls.ACCEPT_ORDER}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return null;

    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrderDetailsResponse> updateOrder(UpdateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.ACCEPT_ORDER}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return null;

    return OrderDetailsResponse.fromJson(response);
  }
}
