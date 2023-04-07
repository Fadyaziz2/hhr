import 'dart:async';
import 'package:meta_club_api/meta_club_api.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated}

class AuthenticationRepository{

  final MetaClubApiClient apiClient;
  AuthenticationStatus initialStatus = AuthenticationStatus.unauthenticated;

  AuthenticationRepository({required this.apiClient});

  final _controller = StreamController<AuthenticationStatus>();
  final _userController = StreamController<LoginData>();

  void updateAuthenticationStatus(AuthenticationStatus status){
    initialStatus = status;
  }

  void updateUserData(LoginData data){
    _userController.add(data);
  }

  void clearUserData(LoginData data){
    _userController.add(data);
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(microseconds: 300));
    yield initialStatus;
    yield* _controller.stream;
  }

  Stream<LoginData> get loginData async* {
    await Future<void>.delayed(const Duration(microseconds: 300));
    yield* _userController.stream;
  }

  Future<LoginData?> login({required String phone,required String password}) async {

    final user = await apiClient.login(phone: phone, password: password);

    if(user != null){
      if(user.user?.isVerified == 0 && user.user?.isActive == 0){
        _controller.add(AuthenticationStatus.unauthenticated);
      }else{
        _controller.add(AuthenticationStatus.authenticated);
        _userController.add(user);
      }
    }else{
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return user;
  }

  void logout(){
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

}

