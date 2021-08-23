import 'dart:math';

import 'package:c4d/module_notifications/model/notification_model.dart';
import 'package:flutter/cupertino.dart';
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
    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true,
      
        );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'local_notifications', 'Loacle notifications', 'Showing notifications while the app running',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            showWhen: true,
            channelShowBadge: true,
            enableLights: true,
            enableVibration: true,
            onlyAlertOnce: false,
            category: 'Locale',  
            );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
        model.id, model.title, model.body, platformChannelSpecifics,
        payload: model.payLoad.clickAction);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      _onNotificationRecieved.add(payload);
    }
  }

  Future onDidNotification(int id, String title, String body, String payload) {
    _onNotificationRecieved.add(payload);
  }
}
