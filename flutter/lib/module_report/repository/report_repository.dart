import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_report/request/report_request.dart';
import 'package:inject/inject.dart';

@provide
class ReportRepository {
  final ApiClient _apiClient;
  final AuthService _authService;

  ReportRepository(this._apiClient, this._authService);

  Future<dynamic> createReport(ReportRequest request) async {
    await _authService.refreshToken();
    var token = await _authService.getToken();

    await _apiClient.post(Urls.REPORT_API, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});

    return null;
  }
}
