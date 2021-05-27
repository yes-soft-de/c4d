import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:inject/inject.dart';

@provide
class NotificationRepo {
  final ApiClient _apiClient;
  final AuthService _authService;

  NotificationRepo(this._apiClient, this._authService);

  void postToken(String token) {
    _authService.getToken().then(
      (value) {
        if (value != null) {
          if (token != null) {
            _apiClient.post(Urls.NOTIFICATION_API, {'token': token},
                headers: {'Authorization': 'Bearer ${value}'});
          }
        }
      },
    );
  }
}
