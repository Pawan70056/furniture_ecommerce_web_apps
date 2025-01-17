import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/auth/data/model/auth_hive_model.dart';

class HiveService {
  final String userBoxName = 'userBox';

  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(UserModelAdapter()); // Register UserModel Adapter
  }

  Future<void> addUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    await box.put(user.userId, user);
  }

  Future<UserModel?> getUser(String userId) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    return box.get(userId);
  }
}
