import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_service/dio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:tf_dio_cache/tf_dio_cache.dart';
import 'http_service.dart';
import 'interceptor/dio_connectivity_request_retrier.dart';
import 'interceptor/retry_interceptor.dart';

class HttpServiceImpl implements HttpService {
  late Dio? _dio;
  late DioCacheManager _manager;
  final String token;

  HttpServiceImpl({required this.token}) {
    init();
  }

  @override
  Future<Response> getRequest(String url) async {
    Response response;

    try {
      response = await _dio!.get(url);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        debugPrint('unAuthentication');
        throw UnAuthenticationException();
      } else {
        debugPrint(e.message);
        throw Exception(e.message);
      }
    }

    return response;
  }

  @override
  Future<Response?> getRequestWithToken(String url,
      {contentType = 'application/json'}) async {
    Response response;

    try {
      response = await _dio!.get(url, options: _buildCacheOptions());
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioException catch (e) {
      debugPrint(e.message);
      return e.response;
    }

    return response;
  }

  @override
  void init() {
    _dio = Dio();
    _dio!.interceptors.add(_getCacheManager().interceptor);
    _dio!.interceptors.add(RetryOnConnectionInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
            dio: _dio, connectivity: Connectivity())));
  }

  DioCacheManager _getCacheManager() {
    _manager = DioCacheManager(
        CacheConfig(baseUrl: 'https://hrm.onestweb.com/api/V11/'));
    return _manager;
  }

  Options _buildCacheOptions() {
    return buildCacheOptions(const Duration(days: 3),
        maxStale: const Duration(days: 7),
        forceRefresh: true,
        options: Options(
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
            'Charset': 'utf-8',
            "Authorization": "Bearer $token"
          },
        ));
  }

  @override
  Future<Response> postRequest(String url, body,
      {contentType = 'application/json;charset=UTF-8'}) async {
    Response response;

    try {
      response =
          await _dio!.post(url, data: body, options: _buildCacheOptions());
    } on DioException catch (e) {
      String error = DioExceptions.fromDioError(e).toString();
      throw Exception(error);
    }
    return response;
  }

  @override
  Future<Response> deleteRequest(String url) async {
    Response response;

    try {
      response = await _dio!.delete(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
    } on SocketException {
      throw const SocketException('No internet connection');
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        statusCode = dioError.response!.statusCode!;
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "No internet connection";
        break;
    }
  }

  late String message;
  int statusCode = -1;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
