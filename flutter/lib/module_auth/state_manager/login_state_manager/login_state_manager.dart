import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_code_sent.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_error.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_init.dart';
import 'package:c4d/module_auth/ui/states/login_states/login_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class LoginStateManager {
  final AuthService _authService;
  final PublishSubject<LoginState> _loginStateSubject =
      PublishSubject<LoginState>();
  final LoginScreenState _loginScreenState;

  LoginStateManager(this._authService, this._loginScreenState);

  Stream<LoginState> get stateStream => _loginStateSubject.stream;

  void loginCaptain(String phoneNumber) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject.add(LoginStateSuccess(_loginScreenState));
          break;
        case AuthStatus.CODE_SENT:
          _loginStateSubject.add(LoginStateCodeSent(_loginScreenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _loginStateSubject
              .add(LoginStateError(_loginScreenState, 'Code Timeout'));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject
          .add(LoginStateError(_loginScreenState, err.toString()));
    });

    _authService.verifyWithPhone(phoneNumber, UserRole.ROLE_CAPTAIN);
  }

  void loginOwner(String email, String name, String password) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _loginStateSubject.add(LoginStateSuccess(_loginScreenState));
          break;
        default:
          _loginStateSubject.add(LoginStateInit(_loginScreenState));
          break;
      }
    }).onError((err) {
      _loginStateSubject
          .add(LoginStateError(_loginScreenState, err.toString()));
    });

    _authService.registerWithEmailAndPassword(
        email, password, name, UserRole.ROLE_OWNER);
  }

  void confirmCaptainCode(String smsCode) {
    _authService.confirmWithCode(smsCode, UserRole.ROLE_CAPTAIN);
  }
}
