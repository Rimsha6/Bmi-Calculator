import 'package:bmi_calculator/core/consts/styles.dart';
import 'package:flutter/cupertino.dart';
import '../core/consts/colors.dart';
import 'package:flutter/material.dart';

class GenderContainer extends StatelessWidget {
  final String label;
  final String? selectedGender;
  final VoidCallback onTap;

  const GenderContainer({
    super.key,
    required this.label,
    required this.selectedGender,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth / 2.3,
            height: screenHeight / 5,
            decoration: BoxDecoration(
              color: selectedGender?.toLowerCase() == label.toLowerCase() ? grey : blue,
      
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    label == "Female" ? Icons.female : Icons.male,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'bold',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

