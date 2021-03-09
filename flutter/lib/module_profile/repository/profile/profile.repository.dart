import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/get_branches_response.dart';
import 'package:c4d/module_profile/response/get_records_response.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:inject/inject.dart';

@provide
class ProfileRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
    this._apiClient,
    this._authService,
  );

  Future<ProfileResponseModel> getOwnerProfile() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.OWNER_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + token},
    );
    if (response == null) return null;
    try {
      return ProfileResponse.fromJson(response).data;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileResponseModel> getCaptainProfile() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.CAPTAIN_PROFILE_API,
      headers: {'Authorization': 'Bearer ' + token},
    );

    try {
      return ProfileResponse.fromJson(response).data;
    } catch (e, stack) {
      Logger().error(e.toString(),
          '${e.toString()}:\n${stack.toString()}', StackTrace.current);
      return null;
    }
  }

  Future<bool> createOwnerProfile(ProfileRequest profileRequest) async {
    var token = await _authService.getToken();
    dynamic response;
    try {
      response = await _apiClient.post(
        Urls.OWNER_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}
    try {
      await _apiClient.put(
        Urls.OWNER_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}

    if (response != null) return true;

    return false;
  }

  Future<bool> createCaptainProfile(ProfileRequest profileRequest) async {
    var token = await _authService.getToken();

    dynamic response;
    try {
      await _apiClient.post(
        Urls.CAPTAIN_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}
    try {
      await _apiClient.put(
        Urls.CAPTAIN_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}

    if (response == null) return true;

    return false;
  }

  Future<ProfileResponse> updateCaptainProfile(ProfileRequest profileRequest) async {
    var token = await _authService.getToken();

    Map<String, dynamic> response;
    try {
      response = await _apiClient.post(
        Urls.CAPTAIN_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}
    try {
      response = await _apiClient.put(
        Urls.CAPTAIN_PROFILE_API,
        profileRequest.toJson(),
        headers: {'Authorization': 'Bearer ' + token},
      );
    } catch (e) {}

    if (response == null) return null;

    return ProfileResponse.fromJson(response);
  }

  Future<Branch> createBranch(CreateBranchRequest createBranch) async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.post(
      Urls.BRANCHES_API,
      createBranch.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return CreateBranchResponse.fromJson(response).data;
  }

  Future<List<Branch>> getMyBranches() async {
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.BRANCHES_API,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return GetBranchesResponse.fromJson(response).data;
  }

  Future<List<ActivityRecord>> getUserActivityLog() async {
    await _authService.refreshToken();
    var token = await _authService.getToken();
    dynamic response = await _apiClient.get(
      Urls.LOG_API,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) return null;

    return GetRecordsResponse.fromJson(response).data;
  }
}
