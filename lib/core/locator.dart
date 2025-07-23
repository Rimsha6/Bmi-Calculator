import 'package:bmi_calculator/core/services/auth_services.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;
setupLocator() async {
  print("AuthServices calling ...>>>");
  locator.registerLazySingleton(() => AuthServices());
  print("AuthServices registered ...>>>");
}
