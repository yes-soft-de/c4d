

import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_authorization/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:inject/inject.dart';

@provide
class ProfileRepository{
  final ApiClient _apiClient;
  final AuthService _authService;

  ProfileRepository(
      this._apiClient,
      this._authService,
      );

  Future<bool> createProfile(ProfileRequest profileRequest)async{
    String token = await _authService.getToken();
    dynamic response = await _apiClient.post(Urls.PROFILE, profileRequest.toJson(),token: token);

    if(response['status_code']=='201') return true;

    return false;

  }
}