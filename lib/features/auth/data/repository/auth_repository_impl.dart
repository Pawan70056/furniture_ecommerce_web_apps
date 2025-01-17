import 'package:funiture_ecommerce/features/auth/data/data_sources/local_data_source.dart';
import 'package:funiture_ecommerce/features/auth/domain/entity/credentials.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  // Constructor accepting AuthLocalDataSource
  AuthRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<bool> authenticate(String username, String password) async {
    // Simulate network call for authentication
    await Future.delayed(const Duration(seconds: 1));

    // You can still create or use Credentials here if needed
    Credentials credentials = Credentials(email: username, password: password);

    // Check if the credentials match your stored data
    if (username == "Pawan" && password == "12345") {
      return authLocalDataSource.authenticate(credentials);
    } else {
      return false;
    }
  }
}
