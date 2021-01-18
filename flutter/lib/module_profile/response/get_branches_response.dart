import 'package:c4d/module_profile/response/create_branch_response.dart';

class GetBranchesResponse {
  String statusCode;
  String msg;
  List<Branch> data;

  GetBranchesResponse({this.statusCode, this.msg, this.data});

  GetBranchesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <Branch>[];
      json['Data'].forEach((v) {
        data.add(new Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = this.statusCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
