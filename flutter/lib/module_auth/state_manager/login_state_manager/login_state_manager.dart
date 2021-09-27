import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_success.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:flutter/material.dart';
import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  LoginScreenState _screenState;
  final FireNotificationService _fireNotificationService;
  final ProfileService _profileService;
  LoginStateManager(this._authService, this._fireNotificationService,this._profileService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _fireNotificationService.refreshNotificationToken().whenComplete(() {
            checkInited(_screenState);
          });
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _loginStateSubject.add(LoginStateInit(_screenState, error: err));
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void checkInited(LoginScreenState _loginScreenState) {
    
    // Check for name in Profile
    _profileService.getProfile().then((profile) {
      _loginStateSubject
          .add(LoginStateSuccess(_loginScreenState, profile != null));
    });
  
  }

  void loginClient(
    String username,
    String password,
    UserRole userRole,
    LoginScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _authService.loginApi(username, password,userRole);
  }
}
