

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_authorization/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_orders/request/order/order_request.dart';
import 'package:inject/inject.dart';

@provide
class NewOrderRepository{
  final ApiClient _apiClient;
  final AuthService _authService;

  NewOrderRepository(
      this._apiClient,
      this._authService,
      );

  Future<bool> addNewOrder(OrderRequest orderRequest)async{
    String token = await _authService.getToken();
//    dynamic response = await _apiClient.post(Urls.NEW_ORDER, orderRequest.toJson(),token: token);
    dynamic response = await _apiClient.post(
        Urls.NEW_ORDER,
        {
          "fromBranch": orderRequest.fromBranch,
          "destination":[orderRequest.destination],
          "note":orderRequest.note,
          "payment":orderRequest.paymentMethod,
          "recipientName":orderRequest.recipientName,
          "recipientPhone":orderRequest.recipientPhone,
          "date":orderRequest.date
        }
        ,token: token);
    if(response == null ) return false;

    return response['status_code']=='201' ? true : false;

  }
}