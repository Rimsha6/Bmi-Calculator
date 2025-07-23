import 'package:bmi_calculator/models/app_user.dart';
import 'package:flutter/material.dart';

import '../../core/locator.dart';
import '../../core/services/database_services.dart';


class BMIProvider extends ChangeNotifier {
  AppUser appUser = AppUser();
  double _bmi = 0.0;
  String _status = '';
  Color _statusColor = Colors.grey;
  double _idealWeight = 0.0;
  String _description = '';

  double get bmi => _bmi;
  String get status => _status;
  Color get statusColor => _statusColor;
  double get idealWeight => _idealWeight;
  String get description => _description;

  Future<void> calculateBMI(double weight, double height, String gender) async {
    if (height <= 0 || weight <= 0) return;

    final heightInMeters = height / 100;
    _bmi = weight / (heightInMeters * heightInMeters);

    if (_bmi < 18.5) {
      _status = "Underweight";
      _statusColor = Colors.blueGrey;
    } else if (_bmi < 25) {
      _status = "Normal";
      _statusColor = Colors.lightGreen;
    } else if (_bmi < 30) {
      _status = "Overweight";
      _statusColor = Colors.orange;
    } else {
      _status = "Obese";
      _statusColor = Colors.red;
    }
    _description = _getBMIDescription(_status);

    // Ideal weight using  formula
    if (gender == 'Male') {
      _idealWeight = 50 + 0.9 * (height - 152);
    } else {
      _idealWeight = 45.5 + 0.9 * (height - 152);
    }

    appUser.height = height;
    print("Height: $height");
    appUser.weight = weight;
    print("Weight: $weight");
    appUser.gender = gender;
    print("Gender: $gender");

    try {
      final databaseServices = locator<DatabaseServices>();
      await databaseServices.updateUserProfile(appUser);
    } catch (e) {
      print("Failed to update user BMI data: $e");
    }

    notifyListeners();
  }

  String _getBMIDescription(String status) {
    switch (status) {
      case 'Underweight':
        return "Your BMI indicates you are underweight. Consider a balanced diet.";
      case 'Normal':
        return "Great! Your BMI is in the normal range.";
      case 'Overweight':
        return "Your BMI is slightly higher than recommended.";
      case 'Obese':
        return "Your BMI indicates obesity. A lifestyle change is advised.";
      default:
        return "Unable to determine BMI category.";
    }
  }
}

