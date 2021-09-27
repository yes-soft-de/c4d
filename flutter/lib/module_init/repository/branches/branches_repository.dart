import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_init/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_init/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_init/response/branches/branches_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class BranchesRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  BranchesRepository(this._apiClient, this._authService);

  Future<bool> updateBranch(UpdateBranchesRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.put(
      Urls.UPDATE_BRANCH_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response['status_code'] == '204') return true;
    return false;
  }

  Future<BranchListResponse> getBranches() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.UPDATE_BRANCH_API,
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response['status_code'] == '200') {
      return BranchListResponse.fromJson(response);
    }
    return null;
  }
  Future<bool> createBranch(CreateBrancheRequest request) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.UPDATE_BRANCH_API,
      request.toJson(),
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response['status_code'] == '201') return true;
    return false;
  }
}
