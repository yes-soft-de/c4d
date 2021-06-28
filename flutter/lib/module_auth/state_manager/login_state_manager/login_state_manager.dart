import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_code_sent.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_error.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_success.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LoginStateManager {
  final AuthService _authService;
  final ProfileService _profileService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();
  final FireNotificationService _fireNotificationService;
  String _email;
  String _password;

  LoginScreenState _screenState;

  LoginStateManager(
      this._authService, this._profileService, this._fireNotificationService) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _fireNotificationService
              .refreshNotificationToken()
              .whenComplete(() => checkInited(_screenState));

          break;
        case AuthStatus.CODE_SENT:
          _loginStateSubject.add(LoginStateCodeSent(_screenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _loginStateSubject.add(
              LoginStateError(_screenState, 'Code Timeout', _email, _password));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_screenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject.add(
          LoginStateError(_screenState, err.toString(), _email, _password));
    });
  }

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  void loginCaptain(String phoneNumber, LoginScreenState _loginScreenState) {
    _screenState = _loginScreenState;
    _authService.verifyWithPhone(false, phoneNumber, UserRole.ROLE_CAPTAIN);
  }

  void checkInited(LoginScreenState _loginScreenState) {
    // Check for name in Profile
    _profileService.getProfile().then((profile) {
      _loginStateSubject
          .add(LoginStateSuccess(_loginScreenState, profile != null));
    });
  }

  void loginOwner(
    String email,
    String password,
    LoginScreenState _loginScreenState,
  ) {
    _screenState = _loginScreenState;
    _email = email;
    _password = password;

    _authService.signInWithEmailAndPassword(
      email,
      password,
      UserRole.ROLE_OWNER,
      false,
    );
  }

  void confirmCaptainCode(String smsCode, LoginScreenState screenState) {
    _screenState = screenState;
    _authService.confirmWithCode(smsCode, UserRole.ROLE_CAPTAIN, false);
  }
}
