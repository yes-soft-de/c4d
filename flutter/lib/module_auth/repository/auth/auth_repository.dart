import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/module_auth/response/regester_response/regester_response.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:inject/inject.dart';

@provide
class AuthRepository {
  final ApiClient _apiClient;
  final Logger _logger;
  AuthRepository(this._apiClient, this._logger);

  Future<RegisterResponse> createOwner(RegisterRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.SIGN_UP_API_OWNER,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future checkUserType(String role, String token) async {
    dynamic result = await _apiClient.post(Urls.CHECK_USER_ROLE + '/$role', {},
        headers: {'Authorization': 'Bearer $token'});
    if (result == null) return null;

    return true;
  }

  Future<RegisterResponse> createCaptain(RegisterRequest request) async {
    dynamic result = await _apiClient.post(
      Urls.SIGN_UP_API_CAPTAIN,
      request.toJson(),
    );
    if (result == null) return null;
    return RegisterResponse.fromJson(result);
  }

  Future<LoginResponse> getToken(LoginRequest loginRequest) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      loginRequest.toJson(),
    );
    if (result == null) {
      return null;
    }
    return LoginResponse.fromJson(result);
  }
}
