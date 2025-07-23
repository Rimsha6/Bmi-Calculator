import 'package:bmi_calculator/core/consts/colors.dart';
import 'package:bmi_calculator/views/home_screens/bmi_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/consts/styles.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bmiprovider = Provider.of<BMIProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   // String weight = "45";

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0,horizontal:20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Your BMI is",
                  style: TextStyle(
                    fontFamily: regular,
                    color: fontGrey,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: screenWidth / 1.2,
                height: screenHeight / 5.5,
                color: blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // BMI value box
                    Container(
                      height: screenHeight * 0.08,
                      width: screenWidth *0.25,
                      color: blueDarker,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            bmiprovider.bmi > 0 ? bmiprovider.bmi.toStringAsFixed(1) : "—",
                            style: TextStyle(
                              fontFamily: regular,
                              color: white,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                        clipBehavior: Clip.none,
                      children: [
                      Image.asset("assets/images/meter.jpg",
        
                      ),
                        Positioned(
                          top: 26,
                          left: 24,
                          child: Container(
                            width: screenWidth * 0.30,
                            height: screenWidth * 0.11,
                            decoration: BoxDecoration(
                              color: bmiprovider.statusColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                bmiprovider.status,
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18,
                                  fontFamily: italic
                                ),
                              ),
                            ),
                          ),
                        ),
                    ]
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: screenHeight * 0.10,
                color: white,
                child: Column(
                  children: [
                    10.heightBox,
                    Center(
                      child: Text(
                        "Ideal weight for your body type",
                        style: TextStyle(
                          fontFamily: regular,
                          color: darkFontGrey,
                          fontSize: 16.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${bmiprovider.idealWeight.toStringAsFixed(1)} kg (± 2 kg)",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: regular,
                        color: blueDarker,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 22),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Result",
                          style: TextStyle(
                            fontFamily: bold,
                            color: blueDarker,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 22),
                      child: Text(
                        bmiprovider.description,
                        style: TextStyle(
                          fontFamily: italic,
                          color: darkFontGrey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    10.heightBox,
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                  child: Image.asset("assets/images/femaleFitness.jpg", height: screenHeight/3,)),
            ],
          ),
        ),
      ),
    );
  }
}


