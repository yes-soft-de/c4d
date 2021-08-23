import 'package:c4d/module_auth/enums/auth_source.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@provide
class AuthPrefsHelper {
  Future<void> setUserId(String userId) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString('uid', userId);
    return;
  }

  Future<String> getUserId() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('uid');
  }

  Future<void> setUsername(String username) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setString('username', username);
  }

  Future<String> getUsername() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('username');
  }

  Future<void> setEmail(String email) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setString('email', email);
  }

  Future<String> getEmail() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('email');
  }

  Future<void> setPassword(String password) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setString('password', password);
  }

  Future<String> getPassword() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.getString('password');
  }

  Future<bool> isSignedIn() async {
    try {
      String uid = await getToken();
      return uid != null;
    } catch (e) {
      return false;
    }
  }

  Future<AuthSource> getAuthSource() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    var index = preferencesHelper.getInt('auth_source');
    return AuthSource.values[index];
  }

  Future<void> setAuthSource(AuthSource authSource) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    return preferencesHelper.setInt(
      'auth_source',
      authSource == null ? null : authSource.index,
    );
  }

  /// @Function saves token string
  /// @returns void
  Future<void> setToken(String token) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setString(
      'token',
      token,
    );
    await preferencesHelper.setString(
      'token_date',
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> deleteToken() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.remove('token');
    await preferencesHelper.remove('token_date');
  }

  Future<void> cleanAll() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.clear();
  }

  /// @return String Token String
  /// @throw Unauthorized Exception when token is null
  Future<String> getToken() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    var token = await preferencesHelper.getString('token');
    if (token == null) {
      throw AuthorizationException('Token not found');
    }
    return token;
  }

  /// @return DateTime tokenDate
  /// @throw UnauthorizedException when token date not found
  Future<DateTime> getTokenDate() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    var dateStr = await preferencesHelper.getString('token_date');
    if (dateStr == null) {
      throw AuthorizationException('Token date not found');
    }
    return DateTime.parse(dateStr);
  }

  /// @return void
  Future<void> setCurrentRole(UserRole user_type) async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    await preferencesHelper.setInt('role', user_type.index);
  }

  /// @return UserType
  /// @throw UnauthorizedException when no role is set
  Future<UserRole> getCurrentRole() async {
    SharedPreferences preferencesHelper = await SharedPreferences.getInstance();
    var type = await preferencesHelper.getInt('role');
    if (type == null) {
      throw AuthorizationException('User Role not found');
    }
    return UserRole.values[type];
  }
}
