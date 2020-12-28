

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
    String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2MDkxNTgwODEsImV4cCI6MTYwOTE2NTI4MSwicm9sZXMiOlsiUk9MRV9PV05FUiIsInVzZXIiXSwidXNlcm5hbWUiOiJvd25lciJ9.tzYANS7Padd4VyeMCTSPsGcrpoGqW6qJd0djC_ty5j-7JYugs--ZBvlLWBDlwr9K7cj4CfqRqf0hIt2InU5Dq99vkyA3dQFXekmvEBf2PvGKW99AX4zHCulpgMQ7AcBHZl8qkLMtqw-yAdN0ytxQ20xdd0EdGdqis_1mbSkn4FS22YnHIZ45sddfmiVUCJug_1lrq6xMk06wJ97NW3L35QitKH6rgIAJ_CLe0N6ymjkKkUTCqhkMFhVYyeP65Ug-D-fpdoyBvY7sCqY_PU01PJp_Ww-J-ZUrrxQl5K5xDzfZUNsr6RSmdWYo6VNdj4P5Bty-QreKEtnuYoFwiy87C9Z_2E8jk8qzc8rFhbA8aG_pXhbbxGEbb6AOMvggnM4K_vYz1dax3qVFruYXtjD2-0AA_c01vBctzyaiH3X7xsZJT5NzXA0XCfBcqv8dPHesN1GQjCllWeBst8PxlREVW5sObJe5umXsE-UTnOhIYBj5ZJo9_DEC3_Syr6XPJgRowaDss6N3x0DY5BTmU8Vrb2ooej-lrBMbZaSFgoufn7U2vbG04sqcRu7qRZhiVUsd8p0sxOs_hE91qUv5QbUQ7CeMSjrRW4jPIL-RLwBYoMSvXM-0tRUh4Rfqnqy92MJXY4YTU9exc8Ezc9qXxmC6O5xGCmP5IlsWc7stTrS5oD8';
    dynamic response = await _apiClient.get(Urls.OWNER_ORDERS,token: token);
    if(response == null ) return null;

    return   OwnerOrdersResponse.fromJson(response);

  }
}