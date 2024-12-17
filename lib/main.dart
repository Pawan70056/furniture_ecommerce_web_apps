import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/views/cart_view.dart';
import 'package:funiture_ecommerce/views/categories_view.dart';
import 'package:funiture_ecommerce/views/dashboard_view.dart';
import 'package:funiture_ecommerce/views/home_view.dart';
import 'package:funiture_ecommerce/views/settings_view.dart';
import 'views/splash_view.dart';
import 'views/onboarding_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

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
        '/': (context) => SplashView(),
        '/onboarding': (context) => OnboardingView(),
        '/login': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/dashboard': (context) => DashboardView(),
        '/home': (context) => HomeView(),
        '/categories': (context) => CategoriesView(),
        '/cart': (context) => CartView(),
        '/settings': (context) => SettingsView(),
      },
    );
  }
}
