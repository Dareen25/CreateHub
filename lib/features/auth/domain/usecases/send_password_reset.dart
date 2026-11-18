import '../repositories/auth_repository.dart';

class SendPasswordReset {
  const SendPasswordReset(this._repository);
  final AuthRepository _repository;

  Future<void> call({required String email}) =>
      _repository.sendPasswordResetEmail(email: email);
}
