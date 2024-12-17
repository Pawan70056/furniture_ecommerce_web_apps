import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/view/cart_view.dart';
import 'package:funiture_ecommerce/view/categories_view.dart';
import 'package:funiture_ecommerce/view/dashboard_view.dart';
import 'package:funiture_ecommerce/view/home_view.dart';
import 'package:funiture_ecommerce/view/settings_view.dart';
import 'view/splash_view.dart';
import 'view/onboarding_view.dart';
import 'view/login_view.dart';
import 'view/register_view.dart';

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
