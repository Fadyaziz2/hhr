
import 'package:hrm_framework/hrm_framework.dart';

class AppInjection{

  late FrameworkAppInjection _frameworkAppInjection;

  AppInjection(){
    _frameworkAppInjection = FrameworkAppInjection();
  }

  Future<void> initInjection() async {
    _frameworkAppInjection.initInjection();
  }

}


