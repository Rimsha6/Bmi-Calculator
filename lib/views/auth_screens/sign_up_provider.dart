import 'package:bmi_calculator/views/auth_screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/locator.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/custom_auth_result.dart';
import '../../models/app_user.dart';


class SignUpProvider extends ChangeNotifier {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  /// State
  bool isVisiblePassword = true;
  bool isLoading = false;

  /// Form and user data
  final formKey = GlobalKey<FormState>();
  final _authServices = locator<AuthServices>();
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();

  /// New field for confirm password
  String confirmPassword = '';

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  /// Sign up user
  Future<void> signUpUser(BuildContext context) async {
    print("User Name: ${appUser.userName}");
    print("User Email: ${appUser.userEmail}");
    print("User Password: ${appUser.password}");

    appUser.isFirstLogin = true;
    appUser.createdAt = DateTime.now().toString();

    isLoading = true;
    notifyListeners();

    customAuthResult = await _authServices.signUpUser(appUser, context);

    isLoading = false;
    notifyListeners();

    if (customAuthResult.user != null) {
      Get.to(() => LoginScreen());
    } else {
      print("Signup failed: ${customAuthResult.errorMessage}");
    }
  }
}