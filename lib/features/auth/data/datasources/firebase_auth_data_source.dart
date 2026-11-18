import 'package:firebase_auth/firebase_auth.dart';

abstract interface class FirebaseAuthDataSource {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });
  Future<UserCredential> register({
    required String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({required String email});
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  FirebaseAuthDataSourceImpl(this._authFactory);
  final FirebaseAuth Function() _authFactory;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) => _authFactory().signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) => _authFactory().createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  @override
  Future<void> sendPasswordResetEmail({required String email}) =>
      _authFactory().sendPasswordResetEmail(email: email);
}
