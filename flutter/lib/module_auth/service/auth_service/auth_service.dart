import 'package:c4d/module_auth/enums/auth_source.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final FireNotificationService _fireNotificationService;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final PublishSubject _authSubject = PublishSubject();
  Stream get onAuthorized => _authSubject.stream;

  AuthService(
    this._prefsHelper,
    this._authManager,
    this._fireNotificationService,
  );

  Future<bool> loginUser(
    String uid,
    String password,
    String email,
    USER_TYPE role,
    AUTH_SOURCE authSource,
  ) async {
    try {
      await _authManager.register(RegisterRequest(
        userID: uid,
        password: uid,
        roles: [role.toString().split('.')[1]],
      ));
    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }

    LoginResponse loginResult = await _authManager.login(LoginRequest(
      username: uid,
      password: uid,
    ));

    if (loginResult == null) {
      return false;
    }

    await Future.wait([
      _prefsHelper.setUserId(uid),
      _prefsHelper.setAuthSource(authSource),
      _prefsHelper.setToken(loginResult.token),
      _prefsHelper.setCurrentRole(role),
    ]);

    await _fireNotificationService.refreshNotificationToken(loginResult.token);
    return true;
  }

  Future<USER_TYPE> get userRole {
    return _prefsHelper.getCurrentRole();
  }

  Future<String> getToken() async {
    try {
      bool isLoggedIn = await this.isLoggedIn;
      var tokenDate = await this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(DateTime.parse(tokenDate)).inMinutes;
      if (isLoggedIn) {
        if (diff < 0) {
          diff = diff * -1;
        }
        if (diff < 55) {
          return _prefsHelper.getToken();
        }
        await refreshToken();
        return _prefsHelper.getToken();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Map<String, String>> getAuthHeaderMap() async {
    var token = await getToken();
    return {'Authorization': 'Bearer ' + token};
  }

  Future<void> refreshToken() async {
    String uid = await _prefsHelper.getUserId();
    LoginResponse loginResponse = await _authManager.login(LoginRequest(
      username: uid,
      password: uid,
    ));
    await _prefsHelper.setToken(loginResponse.token);
  }

  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Future<String> get userID => _prefsHelper.getUserId();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
