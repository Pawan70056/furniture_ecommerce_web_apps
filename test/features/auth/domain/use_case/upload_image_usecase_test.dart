import 'dart:io';

import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:furniture_shopping/core/error/failure.dart';
import 'package:furniture_shopping/features/auth/domain/repository/auth_repository.dart';
import 'package:furniture_shopping/features/auth/domain/use_case/upload_image_usecase.dart';

// Mocking the repository using Mocktail
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late UploadImageUsecase uploadImageUsecase;

  // Register fallback value for File to avoid issues with matchers like `any()`
  setUpAll(() {
    registerFallbackValue(File('dummy_path'));
  });

  setUp(() {
    // Initialize the mock repository and the use case
    mockAuthRepository = MockAuthRepository();
    uploadImageUsecase = UploadImageUsecase(mockAuthRepository);
  });

  group('UploadImageUsecase', () {
    var file = File('test_image_path');

    test('should return success message when image upload is successful', () async {
      // Arrange: Mock the uploadProfilePicture method to return success (Right)
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => Right('Image uploaded successfully'));

      // Act: Call the use case with the file
      final result = await uploadImageUsecase(UploadImageParams(file: file));

      // Assert: Verify that the result is a Right containing the success message
      expect(result, Right('Image uploaded successfully'));

      // Verify: Ensure that the uploadProfilePicture method was called with the file
      verify(() => mockAuthRepository.uploadProfilePicture(file)).called(1);
    });

    test('should return failure when image upload fails', () async {
      // Arrange: Mock the uploadProfilePicture method to return a failure (Left)
      when(() => mockAuthRepository.uploadProfilePicture(any()))
          .thenAnswer((_) async => Left(Failure(message: 'Image upload failed')));

      // Act: Call the use case with the file
      final result = await uploadImageUsecase(UploadImageParams(file: file));

      // Assert: Verify that the result is a Left containing the failure message
      expect(result, Left(Failure(message: 'Image upload failed')));

      // Verify: Ensure that the uploadProfilePicture method was called with the file
      verify(() => mockAuthRepository.uploadProfilePicture(file)).called(1);
    });
  });
}
