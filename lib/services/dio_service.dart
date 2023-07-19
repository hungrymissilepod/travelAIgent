import 'package:flutter_app_template/app/app.logger.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioService {
  final Logger _logger = getLogger('DioService');
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    final options = BaseOptions(
      baseUrl: 'https://www.google.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    _dio = Dio(options);
  }

  Future<Response> get(String url, {Map<String, dynamic>? parameters}) async {
    _logger.i('GET: $url - ${parameters.toString()}');
    final Response response = await _dio.get(url, queryParameters: parameters);
    _logger.i('GET: $url - ${response.statusCode} - ${response.data}');
    return response;
  }

  Future<Response> post(String url, {Map<String, dynamic>? parameters}) async {
    _logger.i('POST: $url - ${parameters.toString()}');
    final Response response = await _dio.post(url, queryParameters: parameters);
    _logger.i('POST: $url - ${response.statusCode} - ${response.data}');
    return response;
  }

  Future<Response> put(String url, {Map<String, dynamic>? parameters}) async {
    _logger.i('PUT: $url - ${parameters.toString()}');
    final Response response = await _dio.put(url, queryParameters: parameters);
    _logger.i('PUT: $url - ${response.statusCode} - ${response.data}');
    return response;
  }

  Future<Response> patch(String url, {Map<String, dynamic>? parameters}) async {
    _logger.i('PATCH: $url - ${parameters.toString()}');
    final Response response =
        await _dio.patch(url, queryParameters: parameters);
    _logger.i('PATCH: $url - ${response.statusCode} - ${response.data}');
    return response;
  }
}
