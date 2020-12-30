

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_authorization/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OrdersRepository{

  final ApiClient _apiClient;
  final AuthService _authService;


  OrdersRepository(
      this._apiClient,
      this._authService
      );
  Future<OrdersResponse> getNearbyOrders() async {
    String token = await _authService.getToken();

    dynamic response = await _apiClient.get(Urls.NEARBY_ORDERS,token: token);
    if(response == null ) return null;

    return   OrdersResponse.fromJson(response);

  }

}