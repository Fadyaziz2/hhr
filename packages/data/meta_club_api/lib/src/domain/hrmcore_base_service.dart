import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:user_repository/user_repository.dart';

abstract class HRMCoreBaseService {
  Future<Either<Failure, LoginData?>> login(
      {required String email, required String password, String? baseUrl, String? deviceId, String? deviceInfo});
}