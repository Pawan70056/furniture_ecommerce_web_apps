import 'package:hive/hive.dart';

part 'auth_hive_model.g.dart'; // This file will be generated automatically by the Hive code generator.

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String userId; // Unique identifier for the user

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  UserModel({
    required this.userId,
    required this.email,
    required this.password,
  });
}
