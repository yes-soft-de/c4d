import 'package:c4d/utils/logger/logger.dart';

class TermsResponse {
  String statusCode;
  String msg;
  List<Terms> data;

  TermsResponse({this.statusCode, this.msg, this.data});

  TermsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    msg = json['msg'];
    if (json['Data'] != null) {
      data = <Terms>[];
      try {
        json['Data'].forEach((v) {
          data.add(new Terms.fromJson(v));
        });
      } catch (e, stack) {
        Logger().error('Network Error', '${e.toString()}:\n${stack.toString()}', StackTrace.current);
      }
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

class Terms {
  int id;
  String content;

  Terms(
      {this.id,
        this.content,
});

  Terms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}

