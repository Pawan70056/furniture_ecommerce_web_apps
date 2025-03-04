import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/auth_controller.dart';
import 'package:timberr/screens/authentication/register_screen.dart';
import 'package:timberr/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController =
      Get.put(AuthController()); // Ensure controller is initialized
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _forgotPassword() async {
    if (GetUtils.isEmail(email)) {
      await _authController.forgotPassword(email);
    } else {
      kDefaultDialog("Error", "Please enter a valid email address");
    }
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _authController.signIn(email, password);
      if (success) {
        if (kDebugMode) print("✅ Login Successful! Navigating to Home Page...");
        Get.offAll(() => HomeScreen()); // Ensure Home() is correctly imported
      } else {
        if (kDebugMode) print("❌ Login Failed! Check credentials.");
        Get.snackbar("Login Error", "Invalid email or password",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void _toRegisterScreen() {
    Get.off(
      () => const RegisterScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo & Header
                Row(
                  children: [
                    const Flexible(
                      child: Divider(
                          color: kNoghreiSilver,
                          thickness: 1,
                          indent: 30,
                          endIndent: 20),
                    ),
                    SvgPicture.asset("assets/furniture_vector.svg"),
                    const Flexible(
                      child: Divider(
                          color: kNoghreiSilver,
                          thickness: 1,
                          indent: 20,
                          endIndent: 30),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 10, top: 30),
                  child: Text("Hello !", style: kMerriweather30TinGrey),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 30),
                  child: Text("WELCOME BACK", style: kMerriweatherBold24),
                ),

                // Form Fields
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(right: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x408A959E),
                            offset: Offset(0, 7),
                            blurRadius: 30)
                      ],
                    ),
                    child: Column(
                      children: [
                        // Email Field
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 35),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onChanged: (val) => email = val,
                            validator: (val) => (GetUtils.isEmail(val ?? ''))
                                ? null
                                : 'Please enter a valid email',
                            cursorColor: kOffBlack,
                            decoration: inputDecorationConst.copyWith(
                                labelText: "Email"),
                          ),
                        ),

                        // Password Field
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 30),
                          child: TextFormField(
                            onChanged: (val) => password = val,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (val.length < 6) {
                                return 'Password should be at least 6 characters long';
                              }
                              return null;
                            },
                            obscureText: !_showPassword,
                            cursorColor: kOffBlack,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: inputDecorationConst.copyWith(
                              labelText: "Password",
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: _showPassword
                                      ? const Icon(Icons.visibility,
                                          color: Colors.grey)
                                      : const Icon(Icons.visibility_off,
                                          color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Forgot Password
                        TextButton(
                          onPressed: _forgotPassword,
                          child: const Text("Forgot Password",
                              style: kNunitoSansSemiBold18),
                        ),

                        const SizedBox(height: 20),

                        // Sign In Button
                        GestureDetector(
                          onTap: _signIn,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: kOffBlack,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0x50303030),
                                    offset: Offset(0, 10),
                                    blurRadius: 20)
                              ],
                            ),
                            child: Center(
                              child: Text("Sign In",
                                  style: kNunitoSansSemiBold18.copyWith(
                                      color: Colors.white)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign Up Button
                        TextButton(
                          onPressed: _toRegisterScreen,
                          child: const Text("SIGN UP",
                              style: kNunitoSansSemiBold18),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
