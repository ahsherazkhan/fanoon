import 'dart:developer';

import 'package:dio/dio.dart';

class NetworkManager {
  static Dio instance() {

    final dio = Dio(
      BaseOptions(
      
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
        baseUrl: 'https://real-wear-clam.cyclic.app/api/v1',
      ),
    );

    dio.interceptors.add(HttpLogInterceptor());

    return dio;
  }
}

class HttpLogInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("statusCode=${response.statusCode}\n"
        "responseBody=${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("onError: $err\n"
        "Response: ${err.response}");
    //to propagate the errors with the code 400 and 500 so that we can handle them through our logic
    //handler.reject(err);
    super.onError(err, handler);
  }
}
