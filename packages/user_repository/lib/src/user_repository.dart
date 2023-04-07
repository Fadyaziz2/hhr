import 'package:dio_service/dio_service.dart';
import 'package:user_repository/user_repository.dart';

class UserRepository {
  final String token;
  late HttpServiceImpl _httpServiceImpl;

  UserRepository({required this.token}) {
    _httpServiceImpl = HttpServiceImpl(token: token);
  }

  static const _rootUrl = 'https://club.onesttech.com';

  static const _baseUrl = '$_rootUrl/api/v1/';

  Future<LoginData?> getUser() async {
    const String userEndpoint = 'user';
    try {
      final response = await _httpServiceImpl.getRequest('$_baseUrl$userEndpoint');
      if (response.statusCode == 200) {
        return LoginData.fromJson(response.data);
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<bool> logout() async {
    const String logoutEndpoint = 'user';
    try{
      final response = await _httpServiceImpl.postRequest('$_baseUrl$logoutEndpoint', null);

      bool isLogout = response.data['result'];

      if(isLogout){
        return true;
      }else{
        return false;
      }
    }catch(_){
      return false;
    }
  }


  Future<bool> tokenVerification({required String token}) async {

    String api = 'token-alive/$token';

    try {
      final response = await _httpServiceImpl.getRequest('$_baseUrl$api');
      if (response.statusCode != 200) {
        return false;
      }
      return true;
    } catch (_) {
      return false;
    }
  }
}
