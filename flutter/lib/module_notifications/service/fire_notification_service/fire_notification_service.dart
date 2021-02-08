import 'dart:async';
import 'dart:io';

import 'package:c4d/module_notifications/preferences/notification_preferences/notification_preferences.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';
import 'package:c4d/utils/logger/logger.dart';

@provide
class FireNotificationService {
  final NotificationsPrefsHelper _prefsHelper;
  final ProfileService _profileService;
  FireNotificationService(this._prefsHelper, this._profileService);

  static final PublishSubject<String> _onNotificationRecieved =
      PublishSubject();
  static Stream get onNotificationStream => _onNotificationRecieved.stream;

  static StreamSubscription iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> init() async {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    var isActive = await _prefsHelper.getIsActive();
    await setCaptainActive(isActive == true);
  }

  Future<void> refreshNotificationToken(String userAuthToken) async {
    var token = await _fcm.getToken();
    if (token != null && userAuthToken != null) {
      // And Subscribe to the changes
      this._fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
          _onNotificationRecieved.add(message.toString());
        },
        onLaunch: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
        },
        onResume: (Map<String, dynamic> message) async {
          Logger().info('FireNotificationService', 'onMessage: $message');
        },
      );
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
}
