

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/response/owner_orders/owner_orders_response.dart';
import 'package:inject/inject.dart';

@provide
class OwnerOrdersRepository{
  final ApiClient _apiClient;

  OwnerOrdersRepository(
      this._apiClient,
      );

  Future<OwnerOrdersResponse> getOwnerOrders() async{
    //TODO : replace it with stored token later
    dynamic token = await _apiClient.post(
        Urls.CREATE_TOKEN_API,
        {
          "username":"owner",
          "password":"12345"
        }
    );
     dynamic response = await _apiClient.get(Urls.OWNER_ORDERS,token: token['token']);
    if(response == null ) return null;

    return   OwnerOrdersResponse.fromJson(response);

  }
}