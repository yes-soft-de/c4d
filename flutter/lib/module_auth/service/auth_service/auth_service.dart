import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/enums/auth_source.dart';
import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/manager/auth_manager/auth_manager.dart';
import 'package:c4d/module_auth/model/app_user.dart';
import 'package:c4d/module_auth/presistance/auth_prefs_helper.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/subjects.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@provide
class AuthService {
  final AuthPrefsHelper _prefsHelper;
  final AuthManager _authManager;
  final AboutService _aboutService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PublishSubject<AuthStatus> _authSubject = PublishSubject<AuthStatus>();

  String _verificationCode;

  AuthService(
    this._prefsHelper,
    this._authManager,
    this._aboutService,
  );

  // Delegates
  Future<bool> get isLoggedIn => _prefsHelper.isSignedIn();

  Future<String> get userID => _prefsHelper.getUserId();

  Future<UserRole> get userRole => _prefsHelper.getCurrentRole();

  Stream<AuthStatus> get authListener => _authSubject.stream;

  Future<void> _loginApiUser(AppUser user) async {
    // Change This
    LoginResponse loginResult = await _authManager.login(LoginRequest(
        username: user.credential.user.email ?? user.credential.user.uid,
        password: user.credential.user.uid));

    if (loginResult == null) {
      throw UnauthorizedException('Error Creating API Token');
    }

    await Future.wait([
      _prefsHelper.setUserId(user.credential.user.uid),
      _prefsHelper
          .setEmail(user.credential.user.email ?? user.credential.user.uid),
      _aboutService.setInited(),
      _prefsHelper.setPassword(user.credential.user.uid),
      _prefsHelper.setAuthSource(user.authSource),
      _prefsHelper.setToken(loginResult.token),
      _prefsHelper.setCurrentRole(user.userRole),
    ]);

    _authSubject.add(AuthStatus.AUTHORIZED);
  }

  Future<void> _registerApiUser(AppUser user) async {
    try {
      await _authManager.register(RegisterRequest(
        userID: user.credential.user.email ?? user.credential.user.uid,
        password: user.credential.user.uid,
        // This should change from the API side
        roles: [user.userRole.toString().split('.')[1]],
      ));
    } catch (e) {
      // Failed Register Attempt means the process has stopped at some point
      Logger().info('AuthService', 'User Already Exists');
    }
    await _loginApiUser(user);
  }

  void verifyWithPhone(String phone, UserRole role) {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (authCredentials) {
          _auth.signInWithCredential(authCredentials).then((credential) {
            _registerApiUser(AppUser(credential, AuthSource.PHONE, role));
          });
        },
        verificationFailed: (err) {
          _authSubject.addError(err);
        },
        codeSent: (String verificationId, int forceResendingToken) {
          _verificationCode = verificationId;
          _authSubject.add(AuthStatus.CODE_SENT);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _authSubject.add(AuthStatus.CODE_TIMEOUT);
        });
  }

  Future<void> verifyWithGoogle(UserRole role) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();
      Logger().info('AuthStateManager', 'Got Google User');
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await _registerApiUser(AppUser(userCredential, AuthSource.PHONE, role));
    } catch (e) {
      Logger().error('AuthStateManager', e.toString(), StackTrace.current);
    }
  }

  Future<void> verifyWithApple(UserRole role) async {
    var oauthCred = await _createAppleOAuthCred();
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCred);
    await _registerApiUser(AppUser(userCredential, AuthSource.APPLE, role));
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, UserRole role) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _registerApiUser(AppUser(userCredential, AuthSource.EMAIL, role));
    } catch (e) {
      if (e is FirebaseAuthException) {
        FirebaseAuthException x = e;
        Logger().info('AuthService', 'Got Authorization Error: ${x.message}');
        _authSubject.addError(x.message);
      } else {
        _authSubject.addError(e.toString());
      }
    }
  }

  /// This helps create new accounts with email and password
  /// 1. Create a Firebase User
  /// 2. Create an API User
  void registerWithEmailAndPassword(
      String email, String password, String name, UserRole role) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      signInWithEmailAndPassword(email, password, role);
    }).catchError((err) {
      if (err is FirebaseAuthException) {
        FirebaseAuthException x = err;
        Logger().info('AuthService', 'Got Authorization Error: ${x.message}');
        _authSubject.addError(UnauthorizedException(x.message));
      } else {
        _authSubject
            .addError(UnauthorizedException('Error: ${err.toString()}'));
      }
    });
  }

  /// This confirms Phone Number
  /// @return void
  void confirmWithCode(String code, UserRole role) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
      verificationId: _verificationCode,
      smsCode: code,
    );

    _auth.signInWithCredential(authCredential).then((credential) {
      _registerApiUser(AppUser(credential, AuthSource.PHONE, role));
    }).catchError((err) {
      if (err is FirebaseAuthException) {
        FirebaseAuthException x = err;
        throw UnauthorizedException(x.message);
      } else {
        throw UnauthorizedException('Error Registering with Auth Provider');
      }
    });
  }

  /// @return cached token
  /// @throw UnauthorizedException
  /// @throw TokenExpiredException
  Future<String> getToken() async {
    try {
      var tokenDate = await this._prefsHelper.getTokenDate();
      var diff = DateTime.now().difference(tokenDate).inMinutes;
      if (diff.abs() > 55) {
        throw TokenExpiredException('Token is created ${diff} minutes ago');
      }
      return this._prefsHelper.getToken();
    } on UnauthorizedException {
      await _prefsHelper.deleteToken();
      return null;
    } catch (e) {
      return null;
    }
  }

  /// refresh API token, this is done using Firebase Token Refresh
  Future<String> refreshToken() async {
    String uid = await _prefsHelper.getUserId();
    String password = await _prefsHelper.getPassword();
    String email = await _prefsHelper.getEmail();
    LoginResponse loginResponse = await _authManager.login(LoginRequest(
      username: email ?? uid,
      password: password,
    ));
    await _prefsHelper.setToken(loginResponse.token);
    return loginResponse.token;
  }

  /// apple specific function
  Future<OAuthCredential> _createAppleOAuthCred() async {
    final nonce = _createNonce(32);
    final nativeAppleCred = Platform.isIOS
        ? await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          )
        : await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            webAuthenticationOptions: WebAuthenticationOptions(
              redirectUri: Uri.parse(
                  'https://your-project-name.firebaseapp.com/__/auth/handler'),
              clientId: 'your.app.bundle.name',
            ),
            nonce: sha256.convert(utf8.encode(nonce)).toString(),
          );

    return new OAuthCredential(
      providerId: 'apple.com',
      // MUST be "apple.com"
      signInMethod: 'oauth',
      // MUST be "oauth"
      accessToken: nativeAppleCred.identityToken,
      // propagate Apple ID token to BOTH accessToken and idToken parameters
      idToken: nativeAppleCred.identityToken,
      rawNonce: nonce,
    );
  }

  /// apple specific function
  String _createNonce(int length) {
    final random = Random();
    final charCodes = List<int>.generate(length, (_) {
      int codeUnit;

      switch (random.nextInt(3)) {
        case 0:
          codeUnit = random.nextInt(10) + 48;
          break;
        case 1:
          codeUnit = random.nextInt(26) + 65;
          break;
        case 2:
          codeUnit = random.nextInt(26) + 97;
          break;
      }

      return codeUnit;
    });

    return String.fromCharCodes(charCodes);
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _prefsHelper.deleteToken();
    await _prefsHelper.cleanAll();
  }
}
