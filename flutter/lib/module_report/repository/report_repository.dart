import 'package:c4d/consts/urls.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_report/presistance/report_prefs_helper.dart';
import 'package:c4d/module_report/request/report_request.dart';
import 'package:c4d/module_report/response/reoprt_respons.dart';
import 'package:inject/inject.dart';

@provide
class ReportRepository {
  final ApiClient _apiClient;
  final AuthService _authService;
  final ReportPrefsHelper _reportPrefsHelper;
  ReportRepository(this._apiClient, this._authService, this._reportPrefsHelper);

  Future<dynamic> createReport(ReportRequest request) async {
    await _authService.refreshToken();
    var token = await _authService.getToken();

    var response = await _apiClient.post(Urls.REPORT_API, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    Report report = ReportResponse.fromJson(response).data;
    String uuid = await _reportPrefsHelper.getUUId(report.orderId.toString());
    if (report.uuid != null && uuid == null) {
      await _reportPrefsHelper.setUUId(report.uuid,report.orderId.toString());
    }
    return null;
  }
}
