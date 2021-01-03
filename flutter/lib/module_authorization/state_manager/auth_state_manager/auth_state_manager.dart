import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:c4d/module_authorization/enums/auth_source.dart';
import 'package:c4d/module_authorization/service/auth_service/auth_service.dart';
import 'package:c4d/module_authorization/states/auth_states/auth_states.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@provide
class AuthStateManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService;
//  final MyProfileService _profileService;

  AuthStateManager(
    this._authService,
//    this._profileService,
  ) {
    var user = _auth.currentUser;
//    if (user != null) {
//      _continueInterruptedLogin(user);
//    }
  }

  final PublishSubject<AuthState> _stateSubject = PublishSubject();

  Stream<AuthState> get stateStream => _stateSubject.stream;

  Stream<String> get status => _authService.authServiceStateSubject.stream;
  String _verificationId;

//  void SignInWithPhone(String phone) {
//    _authService.authServiceStateSubject.add('Sending SMS to this number');
//    _auth
//        .verifyPhoneNumber(
//            phoneNumber: phone,
//            verificationCompleted: (credentials) {
//              _auth.signInWithCredential(credentials).then((value) async {
//                await _authService.loginUser(
//                  _auth.currentUser.uid,
//                  _auth.currentUser.displayName ?? _auth.currentUser.uid,
//                  null,
//                  AUTH_SOURCE.PHONE,
//                );
//                _stateSubject.add(AuthStateSuccess());
//              }).catchError((err) {
//                _stateSubject.add(AuthStateError(err));
//              });
//            },
//            verificationFailed: (err) {
//              Fluttertoast.showToast(msg: err.message);
//            },
//            codeSent: (String verificationId, int forceResendingToken) {
//              verificationId = verificationId;
//              _stateSubject.add(AuthStateCodeSent());
//            },
//            codeAutoRetrievalTimeout: (verificationId) {
//              _verificationId = verificationId;
//            })
//        .catchError((err) {
//      _authService.authServiceStateSubject.add(err.toString());
//      _stateSubject.add(AuthStateError(err.toString()));
//    });
//  }

//  Future<void> authWithGoogle() async {
//    // Trigger the authentication flow
//    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//
//    if (googleUser == null) {
//      return;
//    }
//
//    // Obtain the auth details from the request
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
//
//    // Create a new credential
//    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );
//
//    // Once signed in, return the UserCredential
//    var result = await FirebaseAuth.instance.signInWithCredential(credential);
//    await _loginUser(result);
//  }

//  Future<void> signInWithApple(bool isCaptain) async {
//    var oauthCred = await _createAppleOAuthCred();
//    UserCredential result =
//        await FirebaseAuth.instance.signInWithCredential(oauthCred);
//    await _loginUser(result,isCaptain);
//  }

  void signWithEmailAndPassword(String email, String password,bool isCaptain) {
    print('Signing in');
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _loginUser(value,isCaptain);
    }).catchError((e) {
      _stateSubject.add(AuthStateError(e.toString()));
    });
  }

  void registerWithEmailAndPassword(
      String email, String password, String username , bool isCaptain) {

    _authService.isLoggedInToFireBase.then((value) {
      if(value){
        signWithEmailAndPassword(email, password ,isCaptain);
      }
      else{
        _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          signWithEmailAndPassword(email, password ,isCaptain);
        }).catchError((e) {
          _stateSubject.add(AuthStateError(e.toString()));
        });
      }
    });


  }

  Future<void> _loginUser(UserCredential result,bool isCaptain, [String username]) async {
    if (result != null) {
      String loginSuccessType = await _authService.loginUser(
        result.user.uid,
        result.user.displayName ?? username ?? result.user.uid.substring(0, 6),
        result.user.email ?? result.user.uid.substring(0, 6),
        isCaptain,
        AUTH_SOURCE.EMAIL,
      );
      ( loginSuccessType == 'captain' )
          ?_stateSubject.add(AuthStateCaptainSuccess())
          :  ( loginSuccessType == 'registeredOwner' )
                  ?_stateSubject.add(AuthStateOwnerSuccess())
                  :_stateSubject.add(AuthStateNotRegisteredOwner());



//      if (loginSuccess) {
//        _stateSubject.add(AuthStateSuccess());
//      }
    }
    _stateSubject.add(AuthStateError('Error logging in'));
  }

  Future<void> loginWithoutFirebase(String email, String password  ,bool isCaptain ) async {

      String loginSuccessType = await _authService.loginWithoutFirebase(
        email,
        password,
        isCaptain
      );
      ( loginSuccessType == 'captain' )
          ?_stateSubject.add(AuthStateCaptainSuccess())
          :  ( loginSuccessType == 'registeredOwner' )
             ?_stateSubject.add(AuthStateOwnerSuccess())
             :_stateSubject.add(AuthStateError('error'));


  }
  Future<void> registerWithoutFirebase(String email, String password, String username ,bool isCaptain ) async {

    String loginSuccessType = await _authService.registerWithoutFirebase(
        username,
        email,
        password,
        isCaptain
    );
    ( loginSuccessType == 'captain' )
        ?_stateSubject.add(AuthStateCaptainSuccess())
        :   ( loginSuccessType == 'notRegisteredOwner' )
        ? _stateSubject.add(AuthStateNotRegisteredOwner())
        :_stateSubject.add(AuthStateError('error'));


  }


//  Future<void> _continueInterruptedLogin(User result,bool isCaptain) async {
//    if (result != null) {
//      String loginSuccess = await _authService.loginUser(
//        result.uid,
//        result.displayName ?? result.uid.substring(0, 6),
//        result.email ?? result.uid.substring(0, 6),
//        isCaptain,
//        AUTH_SOURCE.APPLE,
//      );
//      loginSuccess == 'registered' ?
//      _stateSubject.add(AuthStateSuccess()):
//      _stateSubject.add(AuthStateNotRegisteredUser());
//
////      if (loginSuccess) {
////        _stateSubject.add(AuthStateSuccess());
////      }
//    }
//    _stateSubject.add(AuthStateError('Can\'t Sign in!'));
//  }

//  void confirmWithCode(String code) {
//    Fluttertoast.showToast(
//        msg: 'Confirming Code', toastLength: Toast.LENGTH_LONG);
//    AuthCredential credential = PhoneAuthProvider.credential(
//      verificationId: _verificationId,
//      smsCode: code,
//    );
//
//    if (credential == null) {
//      Logger().error('Auth State Manager', 'Error Getting Credentials');
//    }
//    _auth.signInWithCredential(credential).then((result) async {
//      if (result != null) {
//        await _loginUser(result);
//      } else {
//        await Fluttertoast.showToast(msg: 'Error Signing in');
//      }
//    }).catchError((err, stack) {
//      FirebaseCrashlytics.instance.recordError(err, stack);
//    });
//  }

//  Future<OAuthCredential> _createAppleOAuthCred() async {
//    final nonce = _createNonce(32);
//    final nativeAppleCred = Platform.isIOS
//        ? await SignInWithApple.getAppleIDCredential(
//            scopes: [
//              AppleIDAuthorizationScopes.email,
//              AppleIDAuthorizationScopes.fullName,
//            ],
//            nonce: sha256.convert(utf8.encode(nonce)).toString(),
//          )
//        : await SignInWithApple.getAppleIDCredential(
//            scopes: [
//              AppleIDAuthorizationScopes.email,
//              AppleIDAuthorizationScopes.fullName,
//            ],
//            webAuthenticationOptions: WebAuthenticationOptions(
//              redirectUri: Uri.parse(
//                  'https://your-project-name.firebaseapp.com/__/auth/handler'),
//              clientId: 'your.app.bundle.name',
//            ),
//            nonce: sha256.convert(utf8.encode(nonce)).toString(),
//          );
//
//    return new OAuthCredential(
//      providerId: 'apple.com',
//      // MUST be "apple.com"
//      signInMethod: 'oauth',
//      // MUST be "oauth"
//      accessToken: nativeAppleCred.identityToken,
//      // propagate Apple ID token to BOTH accessToken and idToken parameters
//      idToken: nativeAppleCred.identityToken,
//      rawNonce: nonce,
//    );
//  }

//  String _createNonce(int length) {
//    final random = Random();
//    final charCodes = List<int>.generate(length, (_) {
//      int codeUnit;
//
//      switch (random.nextInt(3)) {
//        case 0:
//          codeUnit = random.nextInt(10) + 48;
//          break;
//        case 1:
//          codeUnit = random.nextInt(26) + 65;
//          break;
//        case 2:
//          codeUnit = random.nextInt(26) + 97;
//          break;
//      }
//
//      return codeUnit;
//    });
//
//    return String.fromCharCodes(charCodes);
//  }

  Future<bool> isSignedIn() async {
    return _authService.isLoggedIn;
  }
  Future<bool> isCaptain() async {
    return _authService.isCaptain;
  }
}
