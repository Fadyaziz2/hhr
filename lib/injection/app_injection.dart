
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AppInjection{

  late FrameworkAppInjection _frameworkAppInjection;
  late MetaClubApiInjection _metaClubApiInjection;

  AppInjection(){
    _frameworkAppInjection = FrameworkAppInjection();
    _metaClubApiInjection = MetaClubApiInjection();
  }

  Future<void> initInjection() async {
    _frameworkAppInjection.initInjection();
    _metaClubApiInjection.initInjection();
  }

}


