import 'dart:async';
import 'package:core/core.dart';
import 'package:core/src/failure/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:meta_club_api/src/domain/hrmcore_base_service.dart';
import 'package:user_repository/user_repository.dart';

class HRMCoreBaseServiceImpl implements HRMCoreBaseService {
  final ConnectivityStatusProvider connectivityStatusProvider;
  final MetaClubApiClient metaClubApiClient;

  HRMCoreBaseServiceImpl({required this.connectivityStatusProvider,required this.metaClubApiClient});


  @override
  Future<Either<Failure, LoginData?>> login({required String email, required String password, String? baseUrl, String? deviceId, String? deviceInfo}) async {

    final isConnected = await connectivityStatusProvider.isConnected;

    if(!isConnected){
      return const Left(GeneralFailure.networkUnavailable());
    }
    return metaClubApiClient.login(email: email, password: password, baseUrl: baseUrl);
  }
}
