 import 'package:bmi_calculator/core/consts/colors.dart';
import 'package:bmi_calculator/core/consts/styles.dart';
import 'package:bmi_calculator/views/auth_screens/sig_in_provider.dart';
import 'package:bmi_calculator/views/auth_screens/sign_up_screen.dart';
import 'package:bmi_calculator/widgets_common/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets_common/custom_button.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
 import 'package:provider/provider.dart';

 class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
   @override
   Widget build(BuildContext context) {
     double screenWidth=MediaQuery.of(context).size.width;
     double screenHeight=MediaQuery.of(context).size.height;
     return ChangeNotifierProvider(
       create: (context){
         return SignInProvider();
       },
         child: Consumer<SignInProvider>(
         builder: (context, model, child) {
       return Scaffold(
         body: Stack(
             fit: StackFit.expand,
             children: [
               Image.asset('assets/images/yoga.jpeg',fit: BoxFit.fill,),
               Container(
                 color: Colors.black.withOpacity(0.2),
               ),
               Center(
                 child: Container(
                   color: Colors.black.withOpacity(0.25),
                   height: screenHeight * 0.5,
                   width: screenWidth *0.90,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 15),
                     child: Form(
                       key: model.formKey,
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text(
                             'Login',
                             style: TextStyle(
                                 fontFamily: bold,
                                 fontSize: 30,
                                 color: lightGrey
                             ),
                           ),
                           SizedBox(height: 20),
                          CustomTextField(
                            hintText: "Email",
                            controller: model.emailController,
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
                             controller: model.passwordController,
                             obscureText: model.isVisiblePassword,
                             suffixIcon: IconButton(
                               highlightColor: Colors.transparent,
                               splashColor: Colors.white,
                               onPressed: () {
                                 model.togglePasswordVisibility();
                               },
                               icon:
                               model.isVisiblePassword
                                   ? const Icon(
                                 Icons.visibility_off,
                                 size: 20,
                                 color: Colors.white,
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
                           SizedBox(height: 25),
                           customButton(
                             title: model.isLoading ? null : "Log In",
                             color: lightGrey,
                             textColor: Colors.black,
                             width: screenWidth * 0.55,
                             height:  screenHeight *0.0468,
                             onPressed:
                             model.isLoading
                                 ? null
                                 : () async {
                               try {
                                 TextInput.finishAutofillContext();
                                 if (model.formKey.currentState!
                                     .validate()) {
                                   await model.signInUser(context);
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
                                 color: Colors.black,
                                 strokeWidth: 2.5,
                               ),
                             )
                                 : null,
                           ),
                           Spacer(),
                           HStack([
                             "Don't have an account? ".text
                                 .fontFamily(medium).color(lightGrey)
                                 .size(14)
                                 .make(),
                             10.widthBox,
                             " Sign Up ".text
                                 .color(white)
                                 .size(17)
                                 .fontFamily(bold)
                                 .make()
                                 .onTap(() {
                                   Get.to(SignUpScreen());
                             }),
                           ]),


                         ],
                       ),
                     ),
                   ),
                 ),
               ),

             ]
         ),
     );
         }
         ),
     );
   }
}

