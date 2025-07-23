import 'package:bmi_calculator/views/auth_screens/sign_in_screen.dart';
import 'package:bmi_calculator/widgets_common/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../core/consts/colors.dart';
import '../../core/consts/styles.dart';
import '../../widgets_common/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/views/auth_screens/sign_up_provider.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
        create: (context){
          return SignUpProvider();
        },
      child: Consumer<SignUpProvider>(
        builder: (context,model,child){
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/images/yoga.jpeg', fit: BoxFit.fill),
                Container(
                  color: Colors.black.withOpacity(0.2),
                ),
                Center(
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                    height: screenHeight * 0.65,
                    width: screenWidth * 0.90,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 15),
                      child: Form(
                        key: model.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 28,
                                color: lightGrey,
                              ),
                            ),
                            SizedBox(height: 20),
                           CustomTextField(
                      hintText: 'Full Name',
                      preFixIcon: Icon(Icons.person_outlined),
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        model.appUser.userName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                    ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Email',
                              preFixIcon: Icon(Icons.email_outlined),
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                model.appUser.userEmail = value;
                              },
                              validator: (value) {
                                final RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Email";
                                } else if (!emailRegex.hasMatch(value)) {
                                  return "Please enter a valid Email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Password',
                              obscureText: model.isVisiblePassword,
                              textInputAction: TextInputAction.next,

                              preFixIcon: const Icon(Icons.lock_open),
                              onChanged: (value) {
                                model.appUser.password = value;
                              },
                              suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.white,
                                onPressed: model.togglePasswordVisibility,
                                icon:
                                model.isVisiblePassword
                                    ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                  color: Colors.grey,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '  Please enter password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Confirm Password',
                              obscureText: model.isVisiblePassword,
                              textInputAction: TextInputAction.done,
                              preFixIcon: const Icon(Icons.lock_open),
                              onChanged: (value) {
                                model.confirmPassword = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '  Confirm your password';
                                }
                                if (value != model.appUser.password) {
                                  return '  Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 25),
                            customButton(
                              title: model.isLoading ? null : "Sign Up",
                              color: lightGrey,
                              textColor: black,
                              width: screenWidth,
                              height: screenHeight * 0.0468,
                              onPressed:
                              model.isLoading
                                  ? null
                                  : () async {
                                try {
                                  TextInput.finishAutofillContext();
                                  if (model.formKey.currentState!
                                      .validate()) {
                                    await model.signUpUser(context);
                                  }
                                } catch (e) {
                                  print('Login Error: $e');
                                }
                              },
                              child:
                              model.isLoading
                                  ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: black,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : null,
                            ),
                            Spacer(),
                            HStack([
                              "Already have an account? "
                                  .text
                                  .fontFamily(medium)
                                  .color(lightGrey)
                                  .size(14)
                                  .make(),
                              10.widthBox,
                              "Login"
                                  .text
                                  .color(white)
                                  .size(17)
                                  .fontFamily(bold)
                                  .make().onTap((){
                                Get.to(LoginScreen());
                              })
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
      },
      ),
        );

  }
}
