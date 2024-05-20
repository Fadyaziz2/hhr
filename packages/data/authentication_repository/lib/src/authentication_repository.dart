import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final MetaClubApiClient apiClient;
  AuthenticationStatus initialStatus = AuthenticationStatus.unauthenticated;

  AuthenticationRepository({required this.apiClient});

  final _controller = StreamController<AuthenticationStatus>();
  final _userController = StreamController<LoginData>();

  void updateAuthenticationStatus(AuthenticationStatus status) {
    initialStatus = status;
  }

  void updateUserData(LoginData data) {
    _userController.add(data);
  }

  void clearUserData(LoginData data) {
    _userController.add(data);
  }

  Stream<AuthenticationStatus> get status async* {
    yield initialStatus;
    yield* _controller.stream;
  }

  Stream<LoginData> get loginData async* {
    yield* _userController.stream;
  }

  Future<Either<LoginFailure, LoginData?>> login(
      {required String email,
      required String password,
      required String? baseUrl,
      String? deviceId,
      String? deviceInfo}) async {
    final userEither = await apiClient.login(
        email: email,
        password: password,
        baseUrl: baseUrl,
        deviceId: deviceId,
        deviceInfo: deviceInfo);

    userEither.fold(
        (l) => _controller.add(AuthenticationStatus.unauthenticated), (r) {
      _controller.add(AuthenticationStatus.authenticated);
      _userController.add(r!);
    });

    return userEither;
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
