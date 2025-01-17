import 'package:flutter/material.dart';

class SplashConstants {
  // Image paths
  static const String backgroundImage = 'assets/images/splash.png';
  static const String logoImage = 'assets/logo/Logo.png';

  // Texts
  static const String appName = 'Hello !';
  static const String tagline = 'Bringing Comfort to Your Home';

  // Durations
  static const int splashDurationInSeconds = 3;
  static const Duration animationDuration = Duration(seconds: 2);

  // Styling
  static const double logoHeight = 200.0;
  static const double appNameFontSize = 28.0;
  static const double taglineFontSize = 16.0;
}
class OnboardingConstants {
  static const onboardingData = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Welcome to Furniture",
      "description": "Discover a seamless way to connect and share ideas.",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Collaborate Efficiently",
      "description": "Work together with your team in real time.",
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Achieve Your Goals",
      "description": "Stay organized and accomplish tasks effectively.",
    },
  ];

  static const indicatorColorActive = 0xFF000000; // Replace with theme color
  static const indicatorColorInactive = 0xFFAAAAAA; // Replace with theme color
}


// core/constants.dart

class Constants {
  static const String appName = 'Furniture Ecommerce';

  // Colors
  static const Color primaryColor = Colors.teal;
  static const Color secondaryColor = Colors.white;
  
  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  static const TextStyle linkTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

}
