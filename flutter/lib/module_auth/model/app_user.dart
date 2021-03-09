import 'package:c4d/module_auth/enums/auth_source.dart';
import 'package:c4d/module_auth/enums/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  User credential;
  AuthSource authSource;
  UserRole userRole;

  AppUser(this.credential, this.authSource, this.userRole);
}