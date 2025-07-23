import 'package:bmi_calculator/widgets_common/custom_textfield.dart';
import 'package:bmi_calculator/widgets_common/textField_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/consts/colors.dart';
import '../core/consts/styles.dart';

class AgeField extends StatelessWidget {
  final int age;
  final TextEditingController controller;
  const AgeField({super.key, required this.age, required this.controller,});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: screenWidth / 2.3,
        height: screenHeight / 5,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "AGE",
                style: TextStyle(
                  fontFamily: medium,
                  color: blueDarker,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SizedBox(
                  width: screenWidth / 3.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: textFieldMini(
                          //textfield height
                          height: 45,
                          inputFormatters:
                      [FilteringTextInputFormatter.digitsOnly,],
                          controller: controller,
                          keyBoardType: TextInputType.numberWithOptions(decimal: false),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "yrs",
                        style: TextStyle(
                          fontFamily: italic,
                          color: blueDarker,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}