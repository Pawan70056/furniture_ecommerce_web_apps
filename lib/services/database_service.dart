import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      // ✅ Ensure correct table & column names
      final List<dynamic> data = await Supabase.instance.client
          .from('users')
          .select('id, name, email'); // ✅ Correct column name

      if (data.isEmpty) {
        print("❌ No users found.");
        return [];
      }

      return data
          .map((user) => {
                'id': user['id'] ?? 'Unknown ID',
                'name': user['name'] ?? 'Unnamed User',
                'email': user['email'] ?? 'No Email' // ✅ Include email
              })
          .toList();
    } catch (error, stackTrace) {
      print("❌ Error fetching users: $error");
      print("🛠 StackTrace: $stackTrace"); // ✅ Logs for better debugging
      return [];
    }
  }
}
