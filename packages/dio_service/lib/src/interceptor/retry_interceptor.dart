import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionInterceptor implements InterceptorsWrapper {
  final DioConnectivityRequestRetrier? requestRetrier;

  RetryOnConnectionInterceptor({this.requestRetrier});

  bool _shouldRetry(DioError error) {
    if (error.type == DioErrorType.other &&
        error.error != null &&
        error.error is SocketException) {
    }
    return error.type == DioErrorType.other &&
        error.error != null &&
        error.error is SocketException;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
    debugPrint('Path ${options.path}');
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    handler.next(response);
    debugPrint('Response ${response.data}');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {

    handler.next(err);
    debugPrint('onError : ${err.message}');

    if (_shouldRetry(err)) {
      try {
        requestRetrier?.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
