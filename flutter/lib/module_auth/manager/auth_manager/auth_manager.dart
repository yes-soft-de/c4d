import 'package:c4d/module_auth/repository/auth/auth_repository.dart';
import 'package:c4d/module_auth/request/login_request/login_request.dart';
import 'package:c4d/module_auth/request/register_request/register_request.dart';
import 'package:c4d/module_auth/response/login_response/login_response.dart';
import 'package:c4d/module_auth/response/regester_response/regester_response.dart';
import 'package:inject/inject.dart';

@provide
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<RegisterResponse> registerCaptain(RegisterRequest registerRequest) =>
      _authRepository.createCaptain(registerRequest);

        Future<RegisterResponse> registerOwner(RegisterRequest registerRequest) =>
      _authRepository.createOwner(registerRequest);

  Future<LoginResponse> login(LoginRequest loginRequest) =>
      _authRepository.getToken(loginRequest);

  Future userTypeCheck(String role,String token) =>
      _authRepository.checkUserType(role,token);
}
