import 'dart:core';

class TokenExpiredException implements Exception {
  final String msg;
  const TokenExpiredException(this.msg);

  @override
  String toString() {
    return 'Token Expired, Please refresh API token';
  }
}

class UnauthorizedException implements Exception {
  final String msg;
  const UnauthorizedException(this.msg);

  @override
  String toString() {
    return 'Unauthorized';
  }
}

