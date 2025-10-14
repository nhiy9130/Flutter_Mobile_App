import 'package:dio/dio.dart';

class DioClient {
  DioClient({
    required String baseUrl,
    int timeoutMs = 10000,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: timeoutMs),
        receiveTimeout: Duration(milliseconds: timeoutMs),
        sendTimeout: Duration(milliseconds: timeoutMs),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // TODO: inject token from storage
          handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (error, handler) {
          // Normalize errors similar to FE apiClient.ts
          handler.next(error);
        },
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;
}



