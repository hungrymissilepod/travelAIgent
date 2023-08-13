import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:system_proxy/system_proxy.dart';

/*
my ip info (macbook):


  "ip": "209.35.91.170",
  "hostname": "91.35.209.170.bcube.co.uk",
  "city": "Manchester",
  "region": "England",
  "country": "GB",
  "loc": "53.4809,-2.2374",
  "org": "AS56478 Hyperoptic Ltd",
  "postal": "M1",
  "timezone": "Europe/London",
 

*/

class Proxy {
  String host;
  String port;
  bool? markedForDeletion;
  int timesFailed = 0;

  Proxy(this.host, this.port);
}

class HttpProxyService {
  HttpClient httpClient = HttpClient();

  String ipInfo = 'http://ipinfo.io/json';
  String google = 'https://google.com';
  String ipRegsitry = 'http://ipregistry.co/';

  List<Proxy> proxies = [];

  // Future<void> sanitiseProxies() async {
  //   for (int i = 0; i < 50; i++) {
  //     await Future.delayed(Duration(milliseconds: 50));
  //     Proxy p = proxies[i];
  //     // for (Proxy p in proxies) {
  //     _rotateProxy(p.host, p.port);

  //     try {
  //       HttpClientRequest request = await httpClient.getUrl(Uri.parse(ipInfo));
  //       request.headers.persistentConnection = true;
  //       HttpClientResponse response = await request.close();
  //       final String data = await response.transform(utf8.decoder).join();
  //       if (response.statusCode == 200) {
  //         // print(data);
  //         print('good: ${p.host} - ${p.port}');
  //       } else {
  //         p.markedForDeletion = true;
  //         p.timesFailed += 1;
  //         print('bad: ${p.host} - ${p.port}');
  //       }
  //     } catch (e) {
  //       p.markedForDeletion = true;
  //       p.timesFailed += 1;
  //       print('error: ${p.host} - ${p.port}');
  //       // print('error: ${p.host} - ${p.port} - error: ${e.runtimeType}');
  //     }
  //   }
  // }

  Future<void> init() async {
    httpClient.connectionTimeout = Duration(seconds: 3);
    httpClient.idleTimeout = Duration(milliseconds: 3);

    await _loadProxies('assets/good_proxies.txt');
    _rotateProxy(proxies[0].host, proxies[0].port);

    // for (int i = 0; i < 5; i++) {
    //   await sanitiseProxies();
    // }

    // print(proxies);

    // for (int i = 0; i < 10; i++) {
    //   print('host: ${proxies[i].host} - port: ${proxies[i].port} - timesFailed: ${proxies[i].timesFailed}');
    // }

    // print('printing out best ones');

    // for (int i = 0; i < 50; i++) {
    //   if (proxies[i].timesFailed == 0) {
    //     print('host: ${proxies[i].host} - port: ${proxies[i].port} - timesFailed: ${proxies[i].timesFailed}');
    //   }
    // }
  }

  Future<String?> get(
    String baseUrl,
    String path, {
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Uri uri = Uri.https(baseUrl, path, parameters);
      HttpClientRequest request = await httpClient.getUrl(uri);
      request.headers.persistentConnection = true;
      request.headers.add('authority', 'duckduckgo.com');
      request.headers.add('accept', 'application/json, text/javascript, */*; q=0.01');
      request.headers.add('sec-fetch-dest', 'empty');
      request.headers.add('x-requested-with', 'XMLHttpRequest');
      request.headers.add('user-agent',
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36');
      request.headers.add('sec-fetch-site', 'same-origin');
      request.headers.add('sec-fetch-mode', 'cors');
      request.headers.add('referer', 'https://duckduckgo.com/');
      request.headers.add('accept-language', 'en-US,en;q=0.9');
      HttpClientResponse response = await request.close();
      final String data = await response.transform(utf8.decoder).join();
      print(data);
      return data;
    } catch (e) {
      print('error: ${e.runtimeType}');
    }
    return null;

    //   HttpClientRequest request = await httpClient.getUrl(Uri.parse(ipInfo));
    //   request.headers.persistentConnection = true;
    //   HttpClientResponse response = await request.close();
    //   final String data = await response.transform(utf8.decoder).join();
    //   if (response.statusCode == 200) {
    //     // print(data);
    //     print('good: ${p.host} - ${p.port}');
    //   } else {
    //     p.markedForDeletion = true;
    //     p.timesFailed += 1;
    //     print('bad: ${p.host} - ${p.port}');
    //   }
    // } catch (e) {
    //   p.markedForDeletion = true;
    //   p.timesFailed += 1;
    //   print('error: ${p.host} - ${p.port}');
    //   // print('error: ${p.host} - ${p.port} - error: ${e.runtimeType}');
    // }
  }

  Future<void> _loadProxies(String filename) async {
    String data = await rootBundle.loadString(filename);

    List<String> list = LineSplitter.split(data).toList();
    for (var l in list) {
      List<String> split = l.split(':');
      proxies.add(Proxy(split[0], split[1]));
    }
  }

  int current = 0;
  void rotateRandomProxy() {
    if (current < proxies.length) {
      current++;
    } else {
      current = 0;
    }

    _rotateProxy(proxies[current].host, proxies[current].port);
  }

  void _rotateProxy(String host, String port, {bool directConnection = false}) {
    httpClient.findProxy = (url) {
      if (directConnection) {
        return 'DIRECT';
      }
      return 'PROXY $host:$port;';
    };
  }
}
