import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/states/auth_states/auth_states.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class AuthStateManager {
  final AuthService _authService;

  AuthStateManager(this._authService);

  final PublishSubject<AuthState> _stateSubject = PublishSubject();
  Stream<AuthState> get stateStream => _stateSubject.stream;

  void checkLoggedIn() {
    _authService.isLoggedIn.then((value) {
      if (value == true) {
        _stateSubject.add(AuthStateAuthSuccess());
      }
    });
  }

  Future<bool> isSignedIn() async {
    return _authService.isLoggedIn;
  }
}
