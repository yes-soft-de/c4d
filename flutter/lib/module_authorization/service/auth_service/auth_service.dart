
import 'package:c4d/module_authorization/enums/auth_source.dart';
import 'package:c4d/module_authorization/manager/auth/auth_manager.dart';
import 'package:c4d/module_authorization/presistance/auth_prefs_helper.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
//  final MyProfileManager _myProfileManager;
//  final ProfileSharedPreferencesHelper _preferencesHelper;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final PublishSubject<String> authServiceStateSubject = PublishSubject();

  AuthService(
      this._prefsHelper,
      this._authManager,
//      this._myProfileManager,
//      this._preferencesHelper
      );

  Future<String> loginUser(
      String uid, String name, String email,bool isCaptain, AUTH_SOURCE authSource,
      [String image]) async {
    authServiceStateSubject.add('User is Verified, Creating a user in our DB');
    var userExists = false;

    try {
      var token = await _authManager.getToken(uid, uid);

      await _prefsHelper.setToken(token);
      userExists = token != null;
    } catch (e) {
      Logger().info('Auth Service', e);
    }

    try {
      String role = isCaptain?'ROLE_CAPTAIN':'ROLE_OWNER';
      if (!userExists) await _authManager.createUser(uid,role);

    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }
    if(userExists){
//      ProfileResponse response = await _myProfileManager.getBasicProfileInfo(uid);
//      await _preferencesHelper.setUserImage(response.image);
//      await _preferencesHelper.setUserName(response.userName);
//      await _preferencesHelper.setUserStory(response.story);
//      await _preferencesHelper.setUserCover(response.cover);

    }

    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setIsCaptain(isCaptain);
    await _prefsHelper.setUsername(name);
    await _prefsHelper.setAuthSource(authSource);
    if(! userExists ) await refreshToken();

    return isCaptain
              ? 'captain'
              : userExists
                  ?'registeredOwner'
                  :'notRegisteredOwner';


  }

  Future<String> loginWithoutFirebase(
      String username, String email, String password,bool isCaptain,  ) async {
    authServiceStateSubject.add('User is Verified, Creating a user in our DB');
    var userExists = false;

    try {
      var token = await _authManager.getToken(email, password);

      await _prefsHelper.setToken(token);
      userExists = token != null;
    } catch (e) {
      Logger().info('Auth Service', e);
    }

    try {
      String role = isCaptain?'ROLE_CAPTAIN':'ROLE_OWNER';
      if (!userExists) await _authManager.createUserWithoutFirebase(email, password,role);

    } catch (e) {
      Logger().info('AuthService', 'User Already Exists');
    }
    if(userExists){
//      ProfileResponse response = await _myProfileManager.getBasicProfileInfo(uid);
//      await _preferencesHelper.setUserImage(response.image);
//      await _preferencesHelper.setUserName(response.userName);
//      await _preferencesHelper.setUserStory(response.story);
//      await _preferencesHelper.setUserCover(response.cover);

    }

//    await _prefsHelper.setUserId(uid);
    await _prefsHelper.setIsCaptain(isCaptain);
    await _prefsHelper.setUsername(username);
//    await _prefsHelper.setAuthSource(authSource);
    if(! userExists ) await refreshToken();

    return isCaptain
        ? 'captain'
        : userExists
        ?'registeredOwner'
        :'notRegisteredOwner';


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
  Future<void> refreshToken() async {
    String uid = await _prefsHelper.getUserId();
    String token = await _authManager.getToken(uid, uid);
    await _prefsHelper.setToken(token);
  }

  Future<bool> get isLoggedInToFireBase async {
    var user = await _firebaseAuth.currentUser;

    return user != null ;
  }

  Future<bool> get isLoggedIn async {
    var user = await _firebaseAuth.currentUser;
    var savedLogin = await _prefsHelper.isSignedIn();

    return user != null && savedLogin;
  }

  Future<bool> get isCaptain async {
    var user = await _firebaseAuth.currentUser;
    var isCaptain = await _prefsHelper.getIsCaptain();

    return user != null && isCaptain;
  }

  Future<String> get userID => _prefsHelper.getUserId();

  Future<String> get username => _prefsHelper.getUsername();

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _prefsHelper.clearPrefs();
  }
}
