import '../entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthUser> signIn({required String email, required String password});
  Future<AuthUser> register({required String email, required String password});
  Future<void> sendPasswordResetEmail({required String email});
}
