import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum DuckWebImageSize {
  cached,
  small,
  medium,
  large,
  wallpaper,
}

enum DuckWebImageLayout {
  all,
  square,
  tall,
  wide,
}

enum DuckWebImageType {
  all,
  photo,
  clipart,
  gif,
  transparent,
}

class ImageScraperService {
  final DioService _dioService = locator<DioService>();
  final Logger _logger = getLogger('ImageScraperService');

  /// The max number of images to return for each request
  final int maxImagesToReturn = 5;

  final String baseUrl = 'https://duckduckgo.com/';

  /// Headers to be sent with image request
  Map<String, dynamic> headers = <String, dynamic>{
    'authority': 'duckduckgo.com',
    'accept': 'application/json, text/javascript, */*; q=0.01',
    'sec-fetch-dest': 'empty',
    'x-requested-with': 'XMLHttpRequest',
    'user-agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'referer': 'https://duckduckgo.com/',
    'accept-language': 'en-US,en;q=0.9',
  };

  String _getImageSizeFilter(DuckWebImageSize size) {
    if (size == DuckWebImageSize.cached) {
      return '';
    }
    return EnumToString.convertToString(size);
  }

  String _getImageLayoutFilter(DuckWebImageLayout layout) {
    if (layout == DuckWebImageLayout.all) {
      return '';
    }
    return EnumToString.convertToString(layout);
  }

  String _getImageTypeFilter(DuckWebImageType type) {
    if (type == DuckWebImageType.all) {
      return '';
    }
    return EnumToString.convertToString(type);
  }

  /// We need this to query DuckDuckGo initially to get a search token
  Map<String, dynamic> _parameters(String query) {
    return <String, dynamic>{'q': query};
  }

  /// In order to make requests to DuckDuckGo we first need to get a search token
  /// [query] is what we are searching for
  Future<String?> getDuckDuckGoSearchToken(String query) async {
    _logger.i('getDuckDuckGoSearchToken');

    final Map<String, dynamic> parameters = _parameters(query);
    final Response response = await _dioService.get(baseUrl, parameters: parameters);

    /// Use regexp to look for a value with key [vqd]
    /// This is the search token
    RegExp exp = RegExp(
      r'vqd=([\d-]+)\&',
      caseSensitive: false,
      multiLine: true,
    );
    RegExpMatch? match = exp.firstMatch(response.data);

    /// TODO: add a retry thing here so we try 3-5 times?
    if (match?[1] == null) {
      _logger.e('failed to get DuckDuckGo search token');
      return null;
    }

    /// Return DuckDuckGo search token
    return match?[1];
  }

  Future<List<String>?> getImages(
    String query, {
    DuckWebImageSize size = DuckWebImageSize.medium,
    DuckWebImageLayout layout = DuckWebImageLayout.wide,
    DuckWebImageType type = DuckWebImageType.photo,
  }) async {
    /// TODO: we should cache the token so we don't keep getting it.
    /// Need to add a check to see if we get an unauthorized request because that will mean the token is expired, then we should get a new one
    final String? token = await getDuckDuckGoSearchToken(query);
    if (token == null) {
      _logger.e('failed to get DuckDuckGo search token. Cannot search for images');
      return <String>[];
    }

    /// These filters specify what kind of images we will get
    final String filters =
        'size:${_getImageSizeFilter(size)},type:${_getImageTypeFilter(type)},layout:${_getImageLayoutFilter(layout)}';

    /// Parameters specifing our [query], [token], and [filters]
    Map<String, dynamic> params = <String, dynamic>{
      'l': 'us-en',
      'o': 'json',
      'q': query,
      'vqd': token,
      'f': filters,
      'p': '1',
      'v7exp': 'a',
    };

    /// Make a request to the DuckDuckGo image service
    final String imageRequestUrl = "${baseUrl}i.js";
    Response response = await _dioService.get(imageRequestUrl, headers: headers, parameters: params);

    Map data = json.decode(response.data);
    List<dynamic> results = data['results'];

    final List<String> images = <String>[];

    /// Only return [maxImagesToReturn]
    results = results.take(maxImagesToReturn).toList();

    for (dynamic d in results) {
      /// Make sure that [results] contains
      final DuckWebImage duckWebImage = DuckWebImage.fromJson(d);

      /// We can either return thumbnail urls or full image urls
      images.add(duckWebImage.image);
    }
    return images;
  }
}
