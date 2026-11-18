import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class RegisterAccount {
  const RegisterAccount(this._repository);
  final AuthRepository _repository;

  Future<AuthUser> call({required String email, required String password}) =>
      _repository.register(email: email, password: password);
}
