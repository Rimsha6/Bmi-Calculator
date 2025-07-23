import 'package:bmi_calculator/core/consts/colors.dart';
import 'package:bmi_calculator/core/consts/styles.dart';
import 'package:bmi_calculator/models/app_user.dart';
import 'package:bmi_calculator/views/home_screens/bmi_provider.dart';
import 'package:bmi_calculator/views/result_screen/result_screen.dart';
import 'package:bmi_calculator/widgets_common/age_field.dart';
import 'package:bmi_calculator/widgets_common/custom_button.dart';
import 'package:bmi_calculator/widgets_common/gender_container.dart';
import 'package:bmi_calculator/widgets_common/height_field.dart';
import 'package:bmi_calculator/widgets_common/weight_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:bmi_calculator/views/home_screens/bmi_provider.dart';
import 'bmi_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
   String? selectedGender;
  int selectedHeight = 160;

  @override
  Widget build(BuildContext context) {
    final BmiProvider = Provider.of<BMIProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        leading: BackButton(color: white),
        backgroundColor: blueDarker,
        centerTitle: true,
        title: Text(
          "BMI Calculator",
          style: TextStyle(fontFamily: regular, color: white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderContainer(
                  label: "Female",
                  selectedGender: selectedGender,
                  onTap: () {
                    setState(() {
                      selectedGender = "Female";
                    });
                  },
                ),
                GenderContainer(
                  label: "Male",
                  selectedGender: selectedGender,
                  onTap: () {
                    setState(() {
                      selectedGender = "Male";
                      print("Selected gender: $selectedGender");
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Height field
            HeightField(
              height: selectedHeight,
              onChanged: (newHeight) {
                setState(() {
                  selectedHeight = newHeight;
                });
              },
            ),

            const SizedBox(height: 12),

            // Weight & Age fields with flexibility
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(child: WeightField(weight: 24, controller: weightController,)),
                  const SizedBox(width: 10),
                  Expanded(child: AgeField(age: 4,
                  controller: ageController,)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: customButton(
                onPressed: () {
                  final weight = double.tryParse(weightController.text) ?? 0.0;
                  final height = selectedHeight.toDouble();
                  final gender = selectedGender ?? 'Female';
                  BmiProvider.calculateBMI(weight, height, gender);
                  Get.to(ResultScreen());
                },
                title: "Calculate",
                color: blue,
                textColor: white,
                width: screenWidth,
                height: screenHeight / 16,
              ),
            ),
          ],
        ),
  ),
    );
  }
}
