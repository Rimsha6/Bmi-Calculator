import 'package:bmi_calculator/views/auth_screens/sign_in_screen.dart';
import 'package:bmi_calculator/views/auth_screens/sign_up_screen.dart';
import 'package:bmi_calculator/views/home_screens/bmi_provider.dart';
import 'package:bmi_calculator/views/home_screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp( MyApp());}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BMIProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:  LoginScreen(),
      ),
    );
  }
}
