

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_authorization/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusRepository{
  final ApiClient _apiClient;
  final AuthService _authService;


  OrderStatusRepository(
      this._apiClient,
      this._authService
      );

  Future<OrderStatusResponse> getOrderDetails(int oderId)async{

    String token = await _authService.getToken();

    dynamic response = await _apiClient.get(Urls.ORDER_STATUS+'$oderId',token:token  );

    if(response == null ) return null;

    return OrderStatusResponse.fromJson(response['Data']);

  }
}