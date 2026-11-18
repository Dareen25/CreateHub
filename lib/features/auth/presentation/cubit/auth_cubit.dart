import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/failures/auth_failure.dart';
import '../../domain/usecases/register_account.dart';
import '../../domain/usecases/send_password_reset.dart';
import '../../domain/usecases/sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._signIn, this._register, this._sendPasswordReset)
    : super(const AuthState());

  final SignIn _signIn;
  final RegisterAccount _register;
  final SendPasswordReset _sendPasswordReset;

  Future<void> signIn(String email, String password) => _run(() async {
    final user = await _signIn(email: email.trim(), password: password);
    emit(AuthState(status: AuthStatus.success, user: user));
  });

  Future<void> register(String email, String password) => _run(() async {
    final user = await _register(email: email.trim(), password: password);
    emit(AuthState(status: AuthStatus.success, user: user));
  });

  Future<void> sendPasswordReset(String email) => _run(() async {
    await _sendPasswordReset(email: email.trim());
    emit(const AuthState(status: AuthStatus.success));
  });

  Future<void> _run(Future<void> Function() operation) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      await operation();
    } on AuthFailure catch (error) {
      emit(AuthState(status: AuthStatus.failure, errorCode: error.code));
    } catch (_) {
      emit(const AuthState(status: AuthStatus.failure, errorCode: 'unknown'));
    }
  }
}
