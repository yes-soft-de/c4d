import 'package:c4d/module_authorization/repository/auth/auth_repository.dart';
import 'package:inject/inject.dart';

@provide
class AuthManager {
  final AuthRepository _authRepository;
  AuthManager(this._authRepository);

  Future<bool> createUser(String uid,String role) => _authRepository.createUser(uid,role);

  Future<bool> createUserWithoutFirebase(String email,String password,String role)
  => _authRepository.createUserWithoutFirebase(email,password,role);


  Future<String> getToken(String uid, String password) =>
      _authRepository.getToken(uid, password);
}
