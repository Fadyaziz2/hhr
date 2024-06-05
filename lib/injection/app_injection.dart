import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:onesthrm/page/attendance/attendance_app_injection.dart';
import 'package:onesthrm/page/bottom_navigation/bottom_nav_app_injection.dart';
import 'package:onesthrm/page/home/home_app_injection.dart';

class AppInjection {
  late FrameworkAppInjection _frameworkAppInjection;
  late MetaClubApiInjection _metaClubApiInjection;
  late HTTPServiceInjection _httpServiceInjection;
  late AuthenticationInjection _authenticationInjection;
  late DomainAppInjection _domainInjection;
  late UseCaseInjection _useCaseInjection;
  late HomeInjection _homeInjection;
  late BottomNavInjection _bottomNavInjection;
  late AttendanceInjection _attendanceInjection;

  AppInjection() {
    _frameworkAppInjection = FrameworkAppInjection();
    _metaClubApiInjection = MetaClubApiInjection();
    _httpServiceInjection = HTTPServiceInjection();
    _authenticationInjection = AuthenticationInjection();
    _domainInjection = DomainAppInjection();
    _useCaseInjection = UseCaseInjection();
    _homeInjection = HomeInjection();
    _bottomNavInjection = BottomNavInjection();
    _attendanceInjection = AttendanceInjection();
  }

  Future<void> initInjection() async {
    await _httpServiceInjection.initInjection();
    await _frameworkAppInjection.initInjection();
    await _metaClubApiInjection.initInjection();
    await _authenticationInjection.initInjection();
    await _domainInjection.initInjection();
    await _useCaseInjection.initInjection();
    await _homeInjection.initInjection();
    await _bottomNavInjection.initInjection();
    await _attendanceInjection.initInjection();
  }
}
