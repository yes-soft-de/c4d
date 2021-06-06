import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/accept_order_request/accept_order_request.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/response/company_info/company_info.dart';
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
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.NEW_ORDER_API,
      orderRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return false;

    return response['status_code'] == '201' ? true : false;
  }

  Future<String> getCaptainStatus() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_ACTIVE_STATUS_API,
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response == null) return '';
    return response['Data']['status'] ?? '';
  }

  Future<OrderDetailsData> getOrderDetails(int orderId) async {
    if (orderId == null) {
      return null;
    }
    await _authService.refreshToken();
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.ORDER_STATUS_API + '$orderId',
      headers: {'Authorization': 'Bearer $token'},
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
      Urls.NEARBY_ORDERS_API,
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response == null) return null;

    var list = OrdersResponse.fromJson(response).data;
    return list;
  }

  Future<List<Order>> getMyOrders() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();

    try {
      dynamic response = await _apiClient.get(
        Urls.OWNER_ORDERS_API,
        headers: {'Authorization': 'Bearer ${token}'},
      );
      if (response == null) return [];

      return OrdersResponse.fromJson(response).data;
    } catch (e) {
      return [];
    }
  }

  Future<List<Order>> getCaptainOrders() async {
    var token = await _authService.getToken();

    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_ACCEPTED_ORDERS_API,
      headers: {'Authorization': 'Bearer ${token}'},
    );
    if (response == null) return [];
    return OrdersResponse.fromJson(response).data;
  }

  Future<OrderDetailsResponse> acceptOrder(AcceptOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      '${Urls.ACCEPT_ORDER_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return null;

    if (response is String) {
      return OrderDetailsResponse(error: response);
    }

    return OrderDetailsResponse.fromJson(response);
  }

  Future<OrderDetailsResponse> updateOrder(UpdateOrderRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      '${Urls.CAPTAIN_ORDER_UPDATE_API}',
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response == null) return null;

    return OrderDetailsResponse.fromJson(response);
  }

  Future<CompanyInfoResponse> getCompanyInfo() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get('${Urls.COMPANYINFO_API}',
        headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;
    return CompanyInfoResponse.fromJson(response['Data'][0]);
  }

  Future<bool> deleteOrder(int orderId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
        '${Urls.DELETE_ORDER}$orderId', {'state': 'canceled'},
        headers: {'Authorization': 'Bearer $token'});

    if (response == null) return null;
    return response['status_code'].toString() == '204';
  }

  Future<List> getUpdates() async {
    dynamic response = await _apiClient.get('${Urls.UPDATES_API}');

    if (response == null) return null;
    return response['Data'];
  }

  Future<Map> getOrder(int orderId) async {
    dynamic response = await _apiClient.get('${Urls.ORDER_BY_ID}$orderId');

    if (response == null) return null;
    return response['Data'];
  }
}
