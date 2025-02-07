import 'package:furniture_shopping/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping/core/error/failure.dart';
import 'package:furniture_shopping/features/auth/domain/entity/auth_entity.dart';
import 'package:furniture_shopping/features/auth/domain/repository/auth_repository.dart';

// Mocking the repository using Mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase registerUseCase;

  // Register fallback value for AuthEntity
  setUpAll(() {
    registerFallbackValue(AuthEntity(
      fName: 'Dummy',
      lName: 'Dummy',
      phone: '1234567890',
      username: 'dummy_user',
      password: 'dummy_password',
      image: null,
    ));
  });

  setUp(() {
    // Initialize the mock repository and the use case
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const params = RegisterUserParams(
    fname: 'John',
    lname: 'Doe',
    phone: '1234567890',
    username: 'john_doe',
    password: 'password123',
    image: null,
  );

  group('RegisterUseCase', () {
    test('should call registerStudent and return success when registration is successful', () async {
      // Arrange: Mock the registerStudent method to return a success (Right)
      when(() => mockAuthRepository.registerStudent(any()))
          .thenAnswer((_) async => Right(null));

      // Act: Call the use case with the registration parameters
      final result = await registerUseCase(params);

      // Assert: Verify that the result is a Right containing void (success)
      expect(result, Right(null));

      // Verify: Ensure that the registerStudent method was called once with the correct parameters
      verify(() => mockAuthRepository.registerStudent(any())).called(1);
    });

    test('should call registerStudent and return failure when registration fails', () async {
      // Arrange: Mock the registerStudent method to return a failure (Left)
      when(() => mockAuthRepository.registerStudent(any()))
          .thenAnswer((_) async => Left(Failure(message: 'Registration failed')));

      // Act: Call the use case with the registration parameters
      final result = await registerUseCase(params);

      // Assert: Verify that the result is a Left containing a failure
      expect(result, isA<Left<Failure, void>>());

      // Verify: Ensure that the registerStudent method was called once with the correct parameters
      verify(() => mockAuthRepository.registerStudent(any())).called(1);
    });
  });
}
