import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/screens/cart_screen.dart';
import 'package:funiture_ecommerce/screens/categories_screen.dart';
import 'package:funiture_ecommerce/screens/dashboard_screen.dart';
import 'package:funiture_ecommerce/screens/home_screen.dart';
import 'package:funiture_ecommerce/screens/profile_screen.dart';
import 'package:funiture_ecommerce/screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Shop',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/home': (context) => HomeScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
