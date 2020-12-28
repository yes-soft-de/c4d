

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/order_status/order_status_response.dart';
import 'package:inject/inject.dart';

@provide
class OrderStatusRepository{
  final ApiClient _apiClient;

  OrderStatusRepository(
      this._apiClient,
      );

  Future<OrderStatusResponse> getOrderDetails(int oderId)async{

    //TODO : change it later
    dynamic token = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
        {
          "username":"owner",
          "password":"12345"
        }
    );
    dynamic response = await _apiClient.get(Urls.ORDER_STATUS+'oderId',token:token['token'] );

    if(response == null ) return null;

    return OrderStatusResponse.fromJson(response);

  }
}