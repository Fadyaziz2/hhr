import 'package:authentication_repository/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';

class AppInjection {
  late FrameworkAppInjection _frameworkAppInjection;
  late MetaClubApiInjection _metaClubApiInjection;
  late HTTPServiceInjection _httpServiceInjection;
  late AuthenticationInjection _authenticationInjection;
  late DomainAppInjection _domainInjection;

  AppInjection() {
    _frameworkAppInjection = FrameworkAppInjection();
    _metaClubApiInjection = MetaClubApiInjection();
    _httpServiceInjection = HTTPServiceInjection();
    _authenticationInjection = AuthenticationInjection();
    _domainInjection = DomainAppInjection();
  }

  Future<void> initInjection() async {
    await _httpServiceInjection.initInjection();
    await _frameworkAppInjection.initInjection();
    await _metaClubApiInjection.initInjection();
    await _authenticationInjection.initInjection();
    await _domainInjection.initInjection();
  }
}
