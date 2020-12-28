

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
    String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2MDkxNTczODUsImV4cCI6MTYwOTE2NDU4NSwicm9sZXMiOlsiUk9MRV9DQVBUQUlOIiwidXNlciJdLCJ1c2VybmFtZSI6ImNhcHRhaW4ifQ.j-xUAandu7bYaSJf-UOoYZQKLQCUfUN-6_AArzQMqB4F6o0EQpEzKI2QgbK12vurJsH2OezXrztiXvp6hFzhJPsC4e0o1maBVvAWx_U3K7Trp3wYuIR006lEMOvE1JJSGcZ2HDk97Hp0diywDBFIz-iO-azuWKCNnplzM3jruG-nKYpX9rgrSL5xaOnLTU_4GntZzsujkJLw1ZNS-uS68j4aCJ1fvE3tjD-BpVjLLTdFBCm0Dvs9dOlYkWBwh_01Rf2GWFHI4y_KaKNH8TvkiLZxoDtfevCjNzCi4NWoVYrH0TKn4cSND_oGEUiTud68z9MulhdUYmhhxyVHR-bLCv3kMEYxC8Tkm9L4JWCMkuclDKg8gxyJt0XaPxLb19XQnDgQTySjN-69U9WIgu3PuyVt61DvDEDRYF1HyQBLGPxKhXlmCiD5N5sT70NXFC_NBIB5S_caQLzzs0KwYD9_C0r8izskILfFDJ3KYLntxBlDSxwo2NrKGqlBmdy4ByO3PivvIKS0FZ-_V1KQc6XnancV-7xI34GmVQetgC_VEhBAStfG8Dp2hh95_n7GOIp2KPohPViqs080QTzRMFNBbSeRCrirvuABiIBizR60Oca6_EYXzwRYaXzs20FcL2rCDkgEh1R-xjWyDqxgEpnLRrBDlwr1U9yoZ7zqOJ5aoqo';
    dynamic response = await _apiClient.get(Urls.NEARBY_ORDERS,token: token);
    if(response == null ) return null;

    return   OrdersResponse.fromJson(response);

  }

}