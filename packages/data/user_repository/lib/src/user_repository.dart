import 'dart:io';
import 'package:dio_service/dio_service.dart';
import 'package:user_repository/user_repository.dart';
import 'models/token_status.dart';

class UserRepository {
  final String token;
  late HttpServiceImpl _httpServiceImpl;

  UserRepository({required this.token}) {
    _httpServiceImpl = HttpServiceImpl(token: token);
  }

  static const _rootUrl = 'https://kgs.kghrm.com/';

  static const _baseUrl = '$_rootUrl/api/V11/';

  Future<LoginData?> getUser({required String email, required String password}) async {
    const String userEndpoint = 'login';
    final body = {'email': email, 'password': password};
    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$userEndpoint', body);
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
    try {
      final response =
          await _httpServiceImpl.postRequest('$_baseUrl$logoutEndpoint', null);

      bool isLogout = response.data['result'];

      if (isLogout) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<TokenStatus> tokenVerification({required String token,required String baseUrl}) async {
    String api = 'user/token-alive/$token';
    try {
      final response = await _httpServiceImpl.getRequest('$baseUrl$api');
      if (response.statusCode != 200) {
        return TokenStatus(status: false, code: response.statusCode ?? 400);
      }
      return TokenStatus(status: true, code: response.statusCode ?? 200);
    } on SocketException catch (_) {
      return TokenStatus(status: false, code: -1);
    } on DioExceptions {
      return TokenStatus(status: false, code: -1);
    }catch(e){
      if(e is UnAuthenticationException){
        return TokenStatus(status: false, code: 401);
      }
      return TokenStatus(status: false, code: -1);
    }
  }
}
