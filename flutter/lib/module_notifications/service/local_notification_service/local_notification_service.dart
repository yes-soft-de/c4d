import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PublishSubject<String> _onNotificationRecieved =
      PublishSubject();

  Stream get onLocalNotificationStream => _onNotificationRecieved.stream;

  Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(requestSoundPermission: true);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void showNotification(NotificationModel model) {
    IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1', 'c4d', 'delivery app',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
        1, model.title, model.body, platformChannelSpecifics,
        payload: model.payLoad.toString());
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      _onNotificationRecieved.add(payload);
    }
  }
}
