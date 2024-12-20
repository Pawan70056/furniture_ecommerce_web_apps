import 'package:flutter/material.dart';
import 'package:funiture_ecommerce/core/app_theme/app_theme.dart';
import 'package:funiture_ecommerce/views/cart_view.dart';
import 'package:funiture_ecommerce/views/categories_view.dart';
import 'package:funiture_ecommerce/views/dashboard_view.dart';
import 'package:funiture_ecommerce/views/home_view.dart';
import 'package:funiture_ecommerce/views/settings_view.dart';

import 'views/login_view.dart';
import 'views/onboarding_view.dart';
import 'views/register_view.dart';
import 'views/splash_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Shop',
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false, // Removes the DEBUG banner.
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
