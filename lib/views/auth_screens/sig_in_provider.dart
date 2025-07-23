import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../core/locator.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../models/app_user.dart';
import '../home_screens/home_screen.dart';

class SignInProvider extends ChangeNotifier {
  /// Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  /// Auth & User handling
  final _authServices = locator<AuthServices>();
  final authInstance = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();

  /// UI state
  bool isLoading = false;
  bool isVisiblePassword = true;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  /// Sign in user
  Future<void> signInUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      customAuthResult = await _authServices.loginUser(
        email,
        password,
        context,
      );

      /// Optionally handle custom auth result or navigation
      isLoading = false;
      notifyListeners();
      if (customAuthResult.user != null) {
        Get.to( HomeScreen());
      } else {
        print("not showing true");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Sign-in Error: $e");
    }
  }

  /// Dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}