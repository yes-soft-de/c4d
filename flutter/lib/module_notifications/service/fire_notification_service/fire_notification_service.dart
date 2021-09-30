import 'dart:async';
import 'dart:io';

import 'package:c4d/module_network/http_client/http_client.dart';
import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_notifications/repository/notification_repo.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helper/global_key.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class FireNotificationService {
  final NotificationsPrefsHelper _prefsHelper;
  final ProfileService _profileService;
  final NotificationRepo _notificationRepo;

  FireNotificationService(
    this._prefsHelper,
    this._profileService,
    this._notificationRepo,
  );

  static final PublishSubject<Map<String, dynamic>> _onNotificationRecieved =
      PublishSubject();

  Stream get onNotificationStream => _onNotificationRecieved.stream;

  static StreamSubscription iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> init() async {
    print('//////////////////////////////////////////////////////////////////////////////////////////');
    print('###################FIREBASE LOG###############################');
    print('BACKGROUND');
    var back = await _prefsHelper.getBackgroundData();
    print(back.toString());
    print('LAUNCH');
    var launch = await _prefsHelper.getLaunch();
    print(launch.toString());
    print('//////////////////////////////////////////////////////////////////////////////////////////');

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    var isActive = await _prefsHelper.getIsActive();
    await refreshNotificationToken();

    await setCaptainActive(isActive == true);
  }

  Future<void> refreshNotificationToken() async {
    var token = await _fcm.getToken();
    if (token != null) {
      // And Subscribe to the changes
      try {
        _notificationRepo.postToken(token);
        print(token);
        this._fcm.configure(
              onBackgroundMessage:
                  Platform.isIOS ? null : backgroundMessageHandler,
              onMessage: (Map<String, dynamic> message) async {
                Logger().info('FireNotificationService', 'onMessage: $message');
                _onNotificationRecieved.add(message);
              },
              onLaunch: (Map<String, dynamic> message) async {
                Logger().info('FireNotificationService', 'onLaunch: $message');
                await NotificationsPrefsHelper().setLaunch(message);
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(GlobalVariable.navState.currentContext,
                      message['data']['navigate_route'].toString(),arguments:message['data']['argument']);
                },);
              },
              onResume: (Map<String, dynamic> message) async {
                //_onNotificationRecieved.add(message);
                Logger().info('FireNotificationService', 'onResume: $message');
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(GlobalVariable.navState.currentContext,
                      message['data']['navigate_route'].toString(),arguments:message['data']['argument']);
                },);
              },
            );
      } catch (e) {
        Logger().error('action', e.toString(), StackTrace.current);
      }
    }
  }

  Future<void> setCaptainActive(bool active) async {
    await _prefsHelper.setIsActive(active);
    if (active) {
      await _fcm.subscribeToTopic('captains');
    } else {
      await _fcm.unsubscribeFromTopic('captains');
    }
  }

  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    print('AppPushs myBackgroundMessageHandler : $message');
    await NotificationsPrefsHelper().setBackgroundData(message);
    _onNotificationRecieved.add(message);
    return Future<void>.value();
  }
}
