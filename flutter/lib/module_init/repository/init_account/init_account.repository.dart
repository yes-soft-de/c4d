import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/request/create_bank_account/create_bank_account.dart';
import 'package:c4d/module_init/request/create_captain_profile/create_captain_profile_request.dart';
import 'package:c4d/module_init/response/packages/packages_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  InitAccountRepository(this._apiClient, this._authService);

  Future<PackagesResponse> getPackages() async {
    dynamic response = await _apiClient
        .get(Urls.PACKAGES_API,);
    if (response == null) return null;

    return PackagesResponse.fromJson(response);
  }

  Future<bool> subscribePackage(int packageId) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.SUBSCRIPTION_API,
      {'packageID': '$packageId'},
      headers: {'Authorization': 'Bearer ' + token},
    );

    if (response['status_code'] == '201') return true;

    return false;
  }

  Future<dynamic> createCaptainProfile(
      CreateCaptainProfileRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CAPTAIN_PROFILE_API,
      request.toJSON(),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return null;
  }

  Future<dynamic> createBankAccount(
      CreateBankAccountRequest createBankAccountRequest) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.CREATE_BANK_ACCOUNT_API,
      createBankAccountRequest.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );

    return null;
  }
}
