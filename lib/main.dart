import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/private_key.dart' as private_key;
import 'package:timberr/screens/authentication/login_screen.dart';
import 'package:timberr/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: private_key.supabaseUrl,
      anonKey: private_key.supabaseAnonKey,
    );
    debugPrint("✅ Supabase initialized successfully.");
  } catch (e) {
    debugPrint("❌ Error initializing Supabase: $e");
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(const TimberrApp());
}

class TimberrApp extends StatelessWidget {
  const TimberrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // ✅ Ensuring correct initial route
      getPages: [
        GetPage(name: '/', page: () => Wrapper()), // ✅ Root route
        GetPage(name: '/login', page: () => LoginScreen()), // ✅ Login route
      ],
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "NunitoSans",
        appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: kOffBlack),
        ),
      ),
    );
  }
}
