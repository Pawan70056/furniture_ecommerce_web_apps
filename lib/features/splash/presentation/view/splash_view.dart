import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funiture_ecommerce/app/constants/strings.dart';
import 'package:funiture_ecommerce/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:funiture_ecommerce/features/splash/presentation/view_model/splash_bloc.dart';
import 'package:funiture_ecommerce/features/splash/presentation/view_model/splash_event.dart';
import 'package:funiture_ecommerce/features/splash/presentation/view_model/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(NavigateToOnboardingEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardingView()),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                SplashConstants.backgroundImage,
                fit: BoxFit.cover,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo
                    Image.asset(
                      SplashConstants.logoImage,
                      height: SplashConstants.logoHeight,
                    ),
                    const SizedBox(height: 20),
                    // App Name
                    Text(
                      SplashConstants.appName,
                      style: const TextStyle(
                        fontSize: SplashConstants.appNameFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Tagline
                    Text(
                      SplashConstants.tagline,
                      style: const TextStyle(
                        fontSize: SplashConstants.taglineFontSize,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
