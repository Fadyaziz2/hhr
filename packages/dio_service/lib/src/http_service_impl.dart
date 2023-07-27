import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tf_dio_cache/dio_http_cache.dart';
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
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        debugPrint('unAuthentication');
      }
      debugPrint(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response?> getRequestWithToken(String url, {contentType = 'application/json'}) async {
    Response response;

    try {
      response = await _dio!.get(url, options: _buildCacheOptions());
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioError catch (e) {
      debugPrint(e.message);
      return e.response;
      // throw Exception(e.message);
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
    _manager = DioCacheManager(CacheConfig(
        baseUrl: 'https://hrm.onestweb.com/api/V11/',
        defaultRequestMethod: "POST"));
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
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.toString());
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> deleteRequest(String url) async {
    Response response;

    try {
      response = await _dio!.delete(url,
          options: Options(headers: {"Authorization": "Bearer $token"}));
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    }
    return response;
  }
}
