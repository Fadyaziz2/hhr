import 'package:dio/dio.dart';

abstract class HttpService{

  void init();

  Future<Response?> getRequest(String url);
  Future<Response?> getRequestWithToken(String url);
  Future<Response?> deleteRequest(String url);
  Future<Response?> postRequest(String url,body);
}