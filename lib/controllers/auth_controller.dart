import 'package:firebase_auth/firebase_auth.dart';

import 'package:shoe_shop/repositories/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  Future<UserCredential?> signUp(
    String email,
    String password,
  ) async {
    return await _authRepository.signUp(
      email,
      password,
    );
  }

  Future<UserCredential?> signIn(
    String email,
    String password,
  ) async {
    return await _authRepository.signIn(
      email,
      password,
    );
  }

  void deleteUserAccountAndData() {
    _authRepository.deleteUserAccount();
  }

  void resetPassword(String email) async {
    try {
      _authRepository.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
