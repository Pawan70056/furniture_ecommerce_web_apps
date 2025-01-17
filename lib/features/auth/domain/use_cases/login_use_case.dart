
import '../entity/credentials.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<bool> execute(Credentials credentials, String password) async {
    if (!credentials.areValid()) {
      throw Exception("Invalid credentials");
    }

    try {
      final isAuthenticated = await authRepository.authenticate(credentials.email, credentials.password);
      return isAuthenticated;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
