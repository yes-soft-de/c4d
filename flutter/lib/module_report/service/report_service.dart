import 'package:c4d/module_report/manager/report_manager.dart';
import 'package:c4d/module_report/request/report_request.dart';
import 'package:inject/inject.dart';

@provide
class ReportService {
  final ReportManager _manager;
  ReportService(this._manager);

  Future<dynamic> createReport(int id, String reason) {
    return _manager.createReport(ReportRequest(id, reason));
  }
}
