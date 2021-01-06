import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/response/packages/packages_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  InitAccountRepository(this._apiClient, this._authService);

  Future<PackagesResponse> getPackages() async {
    String token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.PACKAGES,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );
    if (response == null) return null;

    return PackagesResponse.fromJson(response);
  }

  Future<bool> subscribePackage(int packageId) async {
    String token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.SUBSCRIPTION,
      {'packageID': '$packageId'},
      headers: {
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response['status_code'] == '201') return true;

    return false;
  }
}
