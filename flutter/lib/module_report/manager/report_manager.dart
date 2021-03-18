import 'package:c4d/module_report/repository/report_repository.dart';
import 'package:c4d/module_report/request/report_request.dart';
import 'package:inject/inject.dart';

@provide
class ReportManager{
  final ReportRepository _repository;
  ReportManager(this._repository);

  Future<dynamic> createReport(ReportRequest request) => _repository.createReport(request);
}