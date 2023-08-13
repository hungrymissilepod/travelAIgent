import 'dart:io';

import 'package:dio/io.dart';
// import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioService {
  final Logger _logger = getLogger('DioService');
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() async {
    // String randomProxy = '45.155.68.129';
    final options = BaseOptions(
      baseUrl: 'https://www.google.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    _dio = Dio(options);
    // ..httpClientAdapter = Http2Adapter(
    //   ConnectionManager(
    //     idleTimeout: Duration(seconds: 10),
    //     onClientCreate: (_, config) {
    //       config.onBadCertificate = (_) => true;
    //       config.proxy = Uri.parse('http://eftdgczv:845klyxttohi@$randomProxy:8133');
    //     },
    //   ),
    // );
    // ..httpClientAdapter = Http2Adapter(
    //   ConnectionManager(
    //     idleTimeout: const Duration(seconds: 10),
    //     onClientCreate: (_, config) => config.proxy = Uri(
    //       path: "http://eftdgczv-rotate:845klyxttohi@p.webshare.io:80/",
    //     ),
    //   ),
    // );

    // Response<String> response;
    // response = await _dio.get('/?xx=6');
    // for (final e in response.redirects) {
    //   print('redirect: ${e.statusCode} ${e.location}');
    // }
    // print(response.data);
  }

  Future<void> setUpProxy() async {
    String proxyApiKey = dotenv.env['PROXY_WEBSHARE_API_KEY']!;
    // Response response = await get('https://proxy.webshare.io/api/v2/profile', headers: {'Authorization': proxyApiKey});
    // print(response.data);

    // String token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIzMTE5NzFjLTY3OTEtNDhhMC05ZmJlLThkMWY2ZjQ1MmRiNyIsImVtYWlsIjoiamFrZS5raW5nbGVlQGd';

    // String token = response.data;

    // Response response2 = await get('http://eftdgczv-rotate:845klyxttohi@p.webshare.io:80/',
    //     headers: {'Authorization': 'Token $proxyApiKey'});

    // Response response = await _dio.get(Uri(path: 'http://eftdgczv-rotate:845klyxttohi@p.webshare.io:80/'));

    String proxy = 'p.webshare.io:80'; //eg 192.168.1.1:8080
    var credentials =
        HttpClientBasicCredentials('eftdgczv-rotate', '845klyxttohi');
    bool isProxyChecked = true;

    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) {
    //     return isProxyChecked && Platform.isAndroid;
    //   };
    //   client.findProxy = (url) {
    //     return isProxyChecked ? 'PROXY $proxy' : 'DIRECT';
    //   };

    //   client.addProxyCredentials('p.webshare.io', 80, 'main', credentials);
    //   return client;
    // };

    // Response response = await _dio.get('https://ipv4.webshare.io/');
    // print(response.data);

    // // final String randomProxy = response.data;
    // String randomProxy = '45.155.68.129';
    // print('randomProxy: $randomProxy');

    // _dio.httpClientAdapter = Http2Adapter(ConnectionManager(
    //   onClientCreate: (_, config) {
    //     config.onBadCertificate = (_) => true;
    //     config.proxy = Uri.parse('http://eftdgczv-rotate:845klyxttohi@$randomProxy:8133');
    //   },
    // ));
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? parameters,
      Map<String, dynamic>? headers,
      bool printResponse = true}) async {
    _logger.i('GET: $url - ${parameters.toString()}');
    final Response response = await _dio.get(url,
        queryParameters: parameters, options: Options(headers: headers));
    if (printResponse) {
      _logger.i('GET: $url - ${response.statusCode} - ${response.data}');
    }
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
