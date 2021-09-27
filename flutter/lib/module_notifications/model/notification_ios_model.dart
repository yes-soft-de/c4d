import 'package:c4d/utils/logger/logger.dart';

class NotificationIosModel {
  Aps aps;
  String customKey;

  NotificationIosModel({this.aps, this.customKey});

  NotificationIosModel.fromJson(dynamic json) {
    try {
      this.aps = json['aps'] == null ? null : Aps.fromJson(json['aps']);
      if (json['customKey'] is String) {
        this.customKey = json['customKey'];
      }
    } catch (e) {
      Logger().error(
        'IOS Notification',
        e,
        StackTrace.current
      );
      Logger().error(
        'IOS Notification details',
        json.toString(),
        StackTrace.current
      );
    }
  }
}

class Aps {
  Alert alert;
  String badge;

  Aps({this.alert, this.badge});

  Aps.fromJson(dynamic json) {
    this.alert = json['alert'] == null ? null : Alert.fromJson(json['alert']);
    if (json['badge'] is String) {
      this.badge = json['badge'];
    }
  }
}

class Alert {
  String body;
  String title;

  Alert({this.body, this.title});

  Alert.fromJson(dynamic json) {
    if (json['body'] is String) {
      this.body = json['body'];
    }
    if (json['title'] is String) {
      this.title = json['title'];
    }
  }
}
