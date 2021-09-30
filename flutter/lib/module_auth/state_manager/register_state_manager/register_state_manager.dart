import 'package:c4d/module_about/service/about_service/about_service.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:c4d/module_auth/ui/screen/register_screen/register_screen.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_success.dart';
import 'package:c4d/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:c4d/module_auth/enums/auth_status.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state.dart';
import 'package:c4d/module_auth/ui/states/register_states/register_state_init.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';

@provide
class RegisterStateManager {
  final AuthService _authService;
  final AboutService _aboutService;
  final FireNotificationService _fireNotificationService;
  final _registerStateSubject = PublishSubject<RegisterState>();
  final _loadingStateSubject = PublishSubject<AsyncSnapshot>();
  RegisterScreenState _registerScreen;

  RegisterStateManager(this._authService,this._aboutService,this._fireNotificationService) {
    _authService.authListener.listen((event) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      switch (event) {
        case AuthStatus.AUTHORIZED:
          _aboutService.setInited().then((value) {
            _registerStateSubject.add(RegisterStateSuccess(_registerScreen));
            _fireNotificationService.refreshNotificationToken();

          });
          break;
        default:
          _registerStateSubject.add(RegisterStateInit(_registerScreen));
          break;
      }
    }).onError((err) {
      _loadingStateSubject.add(AsyncSnapshot.nothing());
      _registerStateSubject.add(RegisterStateInit(_registerScreen, error: err));
    });
  }

  Stream<RegisterState> get stateStream => _registerStateSubject.stream;
  Stream<AsyncSnapshot> get loadingStream => _loadingStateSubject.stream;

  void registerClient(
      RegisterRequest request,UserRole userRole,RegisterScreenState _registerScreenState) {
    _loadingStateSubject.add(AsyncSnapshot.waiting());
    _registerScreen = _registerScreenState;
    _authService
        .registerApi(request,userRole)
        .whenComplete(() => _loadingStateSubject.add(AsyncSnapshot.nothing()));
  }
}
