class HiveTableConstant {
  /// Box names for Hive storage
  static const String userBox = 'userBox'; // Stores user data for login/signup
  static const String authHiveTypeId = 'authHiveTypeId'; // Unique type ID for AuthHiveModel

  /// Type IDs for Hive adapters
  static const int authHiveTypeIdValue = 0; // Ensure this is unique across all adapters
}
