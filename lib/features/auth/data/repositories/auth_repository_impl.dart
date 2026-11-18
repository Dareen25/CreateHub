import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);
  final FirebaseAuthDataSource _dataSource;

  AuthUser _toEntity(User? user) {
    if (user == null) throw const AuthFailure('unknown');
    return AuthUser(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return _toEntity(
        (await _dataSource.signIn(email: email, password: password)).user,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.code);
    } on FirebaseException catch (error) {
      throw AuthFailure(
        error.code == 'no-app' ? 'firebase-not-configured' : error.code,
      );
    }
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    try {
      return _toEntity(
        (await _dataSource.register(email: email, password: password)).user,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.code);
    } on FirebaseException catch (error) {
      throw AuthFailure(
        error.code == 'no-app' ? 'firebase-not-configured' : error.code,
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _dataSource.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.code);
    } on FirebaseException catch (error) {
      throw AuthFailure(
        error.code == 'no-app' ? 'firebase-not-configured' : error.code,
      );
    }
  }
}
