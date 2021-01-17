import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/exceptions/auth_exception.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_code_sent.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_error.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class RegisterStateManager {
  final AuthService _authService;
  final PublishSubject<RegisterState> _registerStateSubject =
      PublishSubject<RegisterState>();

  RegisterStateManager(this._authService);

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;

  void registerCaptain(
      String phoneNumber, RegisterScreenState _registerScreenState) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _registerStateSubject.add(RegisterStateSuccess(_registerScreenState));
          break;
        case AuthStatus.CODE_SENT:
          _registerStateSubject
              .add(RegisterStatePhoneCodeSent(_registerScreenState));
          break;
        case AuthStatus.CODE_TIMEOUT:
          _registerStateSubject
              .add(RegisterStateError(_registerScreenState, 'Code Timeout'));
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreenState));
          break;
      }
    }).onError((err) {
      _registerStateSubject
          .add(RegisterStateError(_registerScreenState, err.toString()));
    });

    _authService.verifyWithPhone(phoneNumber, UserRole.ROLE_CAPTAIN);
  }

  void registerOwner(String email, String name, String password,
      RegisterScreenState _registerScreenState) {
    _authService.authListener.listen((event) {
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _registerStateSubject.add(RegisterStateSuccess(_registerScreenState));
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreenState));
          break;
      }
    }).onError((err) {
      _registerStateSubject
          .add(RegisterStateError(_registerScreenState, err.toString()));
    });

    _authService.registerWithEmailAndPassword(
        email, password, name, UserRole.ROLE_OWNER);
  }

  void confirmCaptainCode(String smsCode) {
    _authService.confirmWithCode(smsCode, UserRole.ROLE_CAPTAIN);
  }
}
