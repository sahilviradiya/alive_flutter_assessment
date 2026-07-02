import 'package:dio/dio.dart';

import 'api_endpoints.dart';

/// Thin wrapper around [Dio] so repositories depend on this instead of
/// the raw package, keeping the app REST-API-ready without any screen
/// currently needing live network calls.
class ApiClient {
  ApiClient._internal(this._dio);

  static final ApiClient instance = ApiClient._internal(
    Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    ),
  );

  final Dio _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return _dio.post<T>(path, data: data);
  }
}
