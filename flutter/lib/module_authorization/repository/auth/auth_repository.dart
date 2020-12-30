
import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<bool> createUser(String uid,String role) async {
    var result = await _apiClient.post(Urls.API_SIGN_UP, {
      'userID': uid,
      'password': uid,
      "roles":[role]
    });

    return result != null;
  }

  Future<bool> createUserWithoutFirebase(String email,String password,String role) async {
    var result = await _apiClient.post(Urls.API_SIGN_UP, {
      'userID': email,
      'password': password,
      "roles":[role]
    });

    return result != null;
  }

  Future<String> getToken(String username, String password) async {
    var result = await _apiClient.post(
      Urls.CREATE_TOKEN_API,
      {
        'username': username,
        'password': password,
      },
    );

    if (result == null) {
      return null;
    }
    return result['token'];
  }
}
