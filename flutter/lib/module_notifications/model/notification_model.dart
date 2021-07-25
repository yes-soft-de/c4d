import 'dart:math';

import 'package:c4d/module_notifications/repository/notification_repo.dart';

class NotificationModel {
  int id;
  String title;
  String body;
  var payLoad;
  NotificationModel({this.id, this.title, this.body, this.payLoad});
  NotificationModel.fromJson(Map<String, dynamic> json) {
    var data = json['data'];
    if (data != null) {
      payLoad = data ?? '';
    }
    var notification = json['notification'];
    if (notification != null) {
      id = notification['id'] ?? Random().nextInt(10000000);
      title = notification['title'];
      body = notification['body'];
    }
  }
}
