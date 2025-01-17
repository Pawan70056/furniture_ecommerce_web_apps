
import 'package:funiture_ecommerce/features/auth/domain/repository/auth_repository.dart';

import '../entity/user.dart';
import '../repository/register_repository.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository, required AuthRepository authRepository});

  Future<String> execute(User user, String confirmPassword) async {
    if (user.password != confirmPassword) {
      throw Exception("Passwords do not match");
    }

    try {
      final registrationResult = await registerRepository.register(user.email, user.password);
      return registrationResult;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
