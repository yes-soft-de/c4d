import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/utils/helper/status_code_hepler.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_auth/response/regester_response/regester_response.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  AuthService(
    this._prefsHelper,
    this._authManager,
  );

  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Stream<AuthStatus> get authListener => _authSubject.stream;

  String get username => _prefsHelper.getUsername() ?? '';
  Future<UserRole> get userRole => _prefsHelper.getCurrentRole();

  Future<void> loginApi(
      String username, String password, UserRole userRole) async {
    LoginResponse loginResult = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResult == null) {
      await logout();
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.invalidCredentials);
    } else if (loginResult.statusCode == '401') {
      await logout();
      _authSubject.addError(S.current.invalidCredentials);
      throw AuthorizationException(S.current.invalidCredentials);
    } else if (loginResult.token == null) {
      await logout();
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          loginResult.statusCode ?? '0'));
    }
    var checkLoginType = await _authManager.userTypeCheck(userRole == UserRole.ROLE_CAPTAIN ? 'ROLE_CAPTAIN' : 'ROLE_OWNER',loginResult.token);
    if (checkLoginType == null) {
      await logout();
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages('403'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages('403'));
    }
    await _prefsHelper.setCurrentRole(userRole);
    await _prefsHelper.setUsername(username);
    await _prefsHelper.setPassword(password);
    await _prefsHelper.setToken(loginResult.token);

    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> registerApi(RegisterRequest request, UserRole userRole) async {
    // Create the profile in our database
    RegisterResponse registerResponse = userRole == UserRole.ROLE_CAPTAIN ? await _authManager.registerCaptain(request) : await _authManager.registerOwner(request);
    if (registerResponse == null) {
      _authSubject.addError(S.current.networkError);
      throw AuthorizationException(S.current.invalidCredentials);
    } else if (registerResponse.statusCode != '201') {
      _authSubject.addError(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
      throw AuthorizationException(StatusCodeHelper.getStatusCodeMessages(
          registerResponse.statusCode ?? '0'));
    }
    await loginApi(request.userID ?? '', request.password ?? '', userRole);
  }

  Future<String> getToken() async {
    try {
      var tokenDate = await this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created ${diff} minutes ago');
      }
      return await this._prefsHelper.getToken();
    } on AuthorizationException {
      await _prefsHelper.deleteToken();
      return null;
    } on TokenExpiredException {
      return await refreshToken();
    } catch (e) {
      await _prefsHelper.cleanAll();
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String> refreshToken() async {
    String username = await _prefsHelper.getUsername();
    String password = await _prefsHelper.getPassword();
    LoginResponse loginResponse = await _authManager.login(LoginRequest(
      username: username,
      password: password,
    ));
    if (loginResponse == null) {
      await _prefsHelper.cleanAll();
      return null;
    }
    await _prefsHelper.setToken(loginResponse.token);

    return loginResponse.token;
  }

  Future<void> logout() async {
    await _prefsHelper.cleanAll();
  }
}
