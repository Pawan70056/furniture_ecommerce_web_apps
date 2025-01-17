import 'package:hive/hive.dart';

import '../../model/auth_hive_model.dart';

class AuthLocalDataSource {
  // Define the box where data will be stored
  final String _boxName = 'authBox';

  Future<Box<UserModel>> _openBox() async {
    // Open the box for storing auth data
    return await Hive.openBox<UserModel>(_boxName);
  }

  // Method to save user credentials in Hive
  Future<void> saveUserCredentials(UserModel authHiveModel) async {
    final box = await _openBox();
    await box.put('user_credentials', authHiveModel);
  }

  // Method to get user credentials from Hive
  Future<UserModel?> getUserCredentials() async {
    final box = await _openBox();
    return box.get('user_credentials');
  }

  // Method to clear user credentials from Hive
  Future<void> clearUserCredentials() async {
    final box = await _openBox();
    await box.delete('user_credentials');
  }
}
