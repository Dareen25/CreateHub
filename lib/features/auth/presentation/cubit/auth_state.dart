import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_user.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorCode,
  });
  final AuthStatus status;
  final AuthUser? user;
  final String? errorCode;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? errorCode,
    bool clearError = false,
  }) => AuthState(
    status: status ?? this.status,
    user: user ?? this.user,
    errorCode: clearError ? null : (errorCode ?? this.errorCode),
  );

  @override
  List<Object?> get props => [status, user, errorCode];
}
