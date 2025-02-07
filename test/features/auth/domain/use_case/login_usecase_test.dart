import 'package:furniture_shopping/features/auth/domain/use_case/login_usecase.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping/app/shared_prefs/token_shared_prefs.dart';
import 'package:furniture_shopping/features/auth/domain/repository/auth_repository.dart';
import 'package:furniture_shopping/core/error/failure.dart';

// Mocking the repository and shared prefs using Mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}
class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late LoginUseCase loginUseCase;

  setUp(() {
    // Initialize the mocks before each test
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();

    // Mock the saveToken method to do nothing (or you can return a value)
    when(() => mockTokenSharedPrefs.saveToken(any())).thenAnswer((_) async {}); // mock the saveToken method

    loginUseCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);
  });

  group('LoginUseCase', () {
    const username = 'testuser';
    const password = 'testpass';
    const token = 'test_token';  // Ensure token is non-null

    test('should return token on successful login', () async {
      // Arrange: Mock the loginStudent method to return a valid token (non-nullable)
      when(() => mockAuthRepository.loginStudent(username, password))
          .thenAnswer((_) async => Right(token)); // Ensure token is non-null

      // Act: Call the use case with the login parameters
      final result = await loginUseCase(LoginParams(username: username, password: password));

      // Assert: Verify that the result is a Right containing the token
      expect(result, Right(token));

      // Verify: Ensure the token is saved in shared prefs
      verify(() => mockTokenSharedPrefs.saveToken(token)).called(1); // Ensure saveToken is called once with token
    });

    test('should return failure on unsuccessful login', () async {
      // Arrange: Mock the loginStudent method to return a failure
      when(() => mockAuthRepository.loginStudent(username, password))
          .thenAnswer((_) async => Left(Failure(message: 'Login failed'))); // Ensure meaningful failure message

      // Act: Call the use case with the login parameters
      final result = await loginUseCase(LoginParams(username: username, password: password));

      // Assert: Verify that the result is a Left containing a failure
      expect(result, isA<Left<Failure, String>>());

      // Verify: Ensure that saveToken is not called in case of failure
      verifyNever(() => mockTokenSharedPrefs.saveToken(any())).called(0); // Use any() matcher from mocktail
    });
  });
}

class LoginUseCase {
  final IAuthRepository authRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.authRepository, this.tokenSharedPrefs);

  Future<Either<Failure, String>> call(LoginParams params) async {
    try {
      final result = await authRepository.loginStudent(params.username, params.password);
      return result.fold(
            (failure) => Left(failure), // If login fails
            (token) async {
          // If login is successful, save token and return it
          await tokenSharedPrefs.saveToken(token);
          return Right(token);
        },
      );
    } catch (e) {
      // Catch any unexpected exceptions and return a failure
      return Left(Failure(message: 'An unexpected error occurred'));
    }

    // Ensure no unreachable code
    throw Exception('Unreachable code');
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

class Failure {
  final String message;
  Failure({required this.message});
}

abstract class IAuthRepository {
  Future<Either<Failure, String>> loginStudent(String username, String password);
}

class TokenSharedPrefs {
  Future<void> saveToken(String token) async {
    // Mock saving token
  }
}
