import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../../models/app_user.dart';
import 'auth_exception_message.dart';
import 'custom_auth_result.dart';
import 'database_services.dart';

class AuthServices{

  final databaseServices = DatabaseServices();
  final customAuthResult = CustomAuthResult();
  final authInstant = FirebaseAuth.instance;
  bool? isLogin;
  User? user;
  AppUser appUser = AppUser();

  Future<void> init() async {
    print("Init called");
    user = authInstant.currentUser;
    print("Firebase User: ${user?.uid}");

    if (user != null) {
      try {
        appUser = await databaseServices.getUser(user!.uid);
        print("Fetched user data: ${appUser.userName}");
        isLogin = true;
      } catch (e) {
        print('Failed to fetch user: $e');
        isLogin = false;
        throw Exception('Failed to fetch user data: $e');
      }
    } else {
      print('No Firebase user');
      isLogin = false;
    }
  }

  /// Signup >>>>>>>>
  Future<CustomAuthResult> signUpUser(
      AppUser appUser,
      BuildContext context,
      ) async {
    try {
      final credential = await authInstant.createUserWithEmailAndPassword(
        email: appUser.userEmail!,
        password: appUser.password!,
      );

      if (credential.user != null) {
        print('User Registered >>>>');
        this.appUser = appUser;
        this.appUser.appUserId = credential.user!.uid;
        isLogin = true;

        await databaseServices.registerUser(appUser);
        this.appUser = await databaseServices.getUser(credential.user!.uid);
        await databaseServices.updateUserProfile(this.appUser);

        customAuthResult.user = credential.user;
      }
    } on FirebaseAuthException catch (e) {
      customAuthResult.errorMessage = _handleFirebaseException(e);
      _showErrorSnackbar("Signup Error", customAuthResult.errorMessage!);
    } catch (e) {
      customAuthResult
          .errorMessage = AuthExceptionsMessages.generateExceptionMessage(e);
      _showErrorSnackbar("Signup Error", customAuthResult.errorMessage!);
    }

    return customAuthResult;
  }

  /// Login >>>>>>>>>>
  Future<CustomAuthResult> loginUser(
      String userEmail,
      String userPassword,
      BuildContext context,
      ) async {
    try {
      final credentials = await authInstant.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      print("User login successfully");

      if (credentials.user != null) {
        customAuthResult.user = credentials.user;
        this.appUser = appUser;
        this.appUser.appUserId = credentials.user!.uid;
        isLogin = true;

        this.appUser = await databaseServices.getUser(credentials.user!.uid);
        await databaseServices.updateUserProfile(this.appUser);
      }
    } on FirebaseAuthException catch (e) {
      customAuthResult.errorMessage = _handleFirebaseException(e);
      _showErrorSnackbar("Login Error", customAuthResult.errorMessage!);
    } catch (e) {
      customAuthResult
          .errorMessage = AuthExceptionsMessages.generateExceptionMessage(e);
      _showErrorSnackbar("Login Error", customAuthResult.errorMessage!);
    }

    return customAuthResult;
  }

  /// Centralized FirebaseAuthException handler
  String _handleFirebaseException(FirebaseAuthException e) {
    print('FirebaseAuthException: ${e.code}');
    switch (e.code) {
      case 'wrong-password':
        return "Invalid password. Please try again.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'invalid-email':
        return "Invalid email address format.";
      case 'user-disabled':
        return "This user account has been disabled.";
      case 'too-many-requests':
        return "Too many login attempts. Try again later.";
      case 'operation-not-allowed':
        return "Email/password sign-in is disabled.";
      default:
        return e.message ?? "An unexpected error occurred.";
    }
  }

  /// Centralized error snackbar
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
  }

  /// Register new user
  Future<void> registerUser(AppUser appUser) async {
    await databaseServices.registerUser(appUser);
    this.appUser = await databaseServices.getUser(appUser.appUserId.toString());
  }

  /// Logout
  Future<void> logoutUser() async {
    await authInstant.signOut();
    isLogin = false;
    appUser = AppUser();
    user = null;

    if (authInstant.currentUser == null) {
      print("User successfully logged out.");
    } else {
      print("Logout failed. User is still authenticated.");
    }
  }
}
