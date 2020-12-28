

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/orders/orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OrdersRepository{

  final ApiClient _apiClient;

  OrdersRepository(
      this._apiClient,
      );

  Future<OrdersResponse> getNearbyOrders() async {
    //TODO : replace it with stored token later
    dynamic token = await _apiClient.post(
        Urls.CREATE_TOKEN_API,
        {
          "username":"captain",
          "password":"12345"
        }
    );
    dynamic response = await _apiClient.get(Urls.NEARBY_ORDERS,token: token['token']);
    if(response == null ) return null;

    return   OrdersResponse.fromJson(response);

  }

}