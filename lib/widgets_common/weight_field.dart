import 'package:bmi_calculator/widgets_common/textField_mini.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/consts/colors.dart';
import '../core/consts/styles.dart';

class WeightField extends StatelessWidget {
  final double weight;
  final TextEditingController controller;
  const WeightField({super.key, required this.weight, required this.controller,});

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "WEIGHT",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: medium,
                  color: blueDarker,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  width: screenWidth / 3.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: textFieldMini(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                             ],
                          controller: controller,
                          height: 45,
                          keyBoardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "kg",
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
