import 'dart:math';

class NotificationModel {
  int id;
  String title;
  String body;
  Payload payLoad;
  NotificationModel({this.id, this.title, this.body, this.payLoad});
  NotificationModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    if (data != null) {
      payLoad = Payload.fromJson(data);
    }
    var notification = json['notification'];
    if (notification != null) {
      id = notification['id'] ?? Random().nextInt(10000000);
      title = notification['title'];
      body = notification['body'];
    }
  }
}

class Payload {
  String clickAction;
  dynamic argument;
  Payload(this.clickAction, this.argument);
  Payload.fromJson(dynamic json) {
    clickAction = json['navigate_route'];
    argument = json['argument'];
  }
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['navigate_route'] = this.clickAction;
    data['argument'] = this.argument;
    return data;
  }
}
