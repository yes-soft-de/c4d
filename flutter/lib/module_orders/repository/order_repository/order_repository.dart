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

  Future<bool> addNewOrder(OrderRequest orderRequest) async {
    String token = await _authService.getToken();
//    dynamic response = await _apiClient.post(Urls.NEW_ORDER, orderRequest.toJson(),token: token);
    dynamic response = await _apiClient.post(
        Urls.NEW_ORDER,
        {
          'fromBranch': orderRequest.fromBranch,
          'destination': [orderRequest.destination],
          'note': orderRequest.note,
          'payment': orderRequest.paymentMethod,
          'recipientName': orderRequest.recipientName,
          'recipientPhone': orderRequest.recipientPhone,
          'date': orderRequest.date
        },
        token: token);
    if (response == null) return false;

    return response['status_code'] == '201' ? true : false;
  }

  Future<OrderStatusResponse> getOrderDetails(int oderId) async {
    String token = await _authService.getToken();
    dynamic response =
        await _apiClient.get(Urls.ORDER_STATUS + '$oderId', token: token);
    if (response == null) return null;
    return OrderStatusResponse.fromJson(response['Data']);
  }

  Future<OrdersResponse> getNearbyOrders() async {
    String token = await _authService.getToken();

    dynamic response = await _apiClient.get(Urls.NEARBY_ORDERS, token: token);
    if (response == null) return null;

    return OrdersResponse.fromJson(response);
  }

  Future<OwnerOrdersResponse> getOwnerOrders() async {
    String token = await _authService.getToken();

    dynamic response = await _apiClient.get(Urls.OWNER_ORDERS, token: token);
    if (response == null) return null;

    return OwnerOrdersResponse.fromJson(response);
  }
}
