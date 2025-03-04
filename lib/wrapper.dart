import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/address_controller.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/controllers/favorites_controller.dart';
import 'package:timberr/controllers/home_controller.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/screens/authentication/onboarding_welcome.dart';
import 'package:timberr/screens/authentication/splash_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);

    if (!mounted) return;

    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // ✅ Prevent multiple controller instances
      if (!Get.isRegistered<HomeController>()) Get.put(HomeController());
      if (!Get.isRegistered<FavoritesController>()) {
        Get.put(FavoritesController());
      }
      if (!Get.isRegistered<CartController>()) Get.put(CartController());
      if (!Get.isRegistered<UserController>()) Get.put(UserController());
      if (!Get.isRegistered<AddressController>()) Get.put(AddressController());
      if (!Get.isRegistered<CardDetailsController>()) {
        Get.put(CardDetailsController());
      }

      Get.offAll(() => SplashScreen(), transition: Transition.fadeIn);
    } else {
      Get.offAll(() => const OnBoardingWelcomeScreen(),
          transition: Transition.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: kOffBlack)),
    );
  }
}
