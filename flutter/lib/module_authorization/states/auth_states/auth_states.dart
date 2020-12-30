class AuthState {}

class AuthStateCaptainSuccess extends AuthState {}

class AuthStateOwnerSuccess extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateCodeSent extends AuthState {}

class AuthStateError extends AuthState {
  String errorMsg;
  AuthStateError(this.errorMsg);
}

class AuthStateInit extends AuthState {}

class AuthStateNotRegisteredOwner extends AuthState {}
