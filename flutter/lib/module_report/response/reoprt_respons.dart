import 'package:c4d/utils/logger/logger.dart';

class ReportResponse {
  String statusCode;
  String msg;
  Report data;

  ReportResponse({this.statusCode, this.msg, this.data});

  ReportResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = Report();
      try {
        data=Report.fromJson(json['Data']);
      } catch (e, stack) {
        Logger().error('Network Error', '${e.toString()}:\n${stack.toString()}', StackTrace.current);
      }
    }
  }
}

class Report {
  int id;
  String userID;
  String userName;
  int orderId;
  String reason;
  String uuid;
  Report(
      {this.id,
        this.userID,
        this.userName,
        this.orderId,
        this.reason,
        this.uuid});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    userName = json['userName'];
    orderId = json['orderId'];
    reason = json['reason'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['orderId'] = this.orderId;
    data['reason'] = this.reason;
    data['uuid'] = this.uuid;
    return data;
  }
}

