import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:travel_aigent/services/duck_duck_go_utils.dart';

class DuckDuckGoLocalImageScraper {
  final Logger _logger = getLogger('DuckDuckGoLocalImageScraperService');
  final DioService _dioService = locator<DioService>();
  final DuckDuckGoUtils utils = DuckDuckGoUtils();

  /// The token we need to make requests to get images
  String _searchToken = '';

  /// In order to make requests to DuckDuckGo we first need to get a search token
  /// [query] is what we are searching for
  Future<String?> _getDuckDuckGoSearchToken(String query) async {
    if (_searchToken.isNotEmpty) {
      _logger.i('already have DuckDuckGo token: $_searchToken');
      return _searchToken;
    }

    final Map<String, dynamic> parameters = utils.parameters(query);
    final Response response = await _dioService.get(
      utils.baseUrl,
      parameters: parameters,
      printResponse: false,
    );

    /// Use regexp to look for a value with key [vqd]
    /// This is the search token
    RegExp exp = RegExp(
      r'vqd=([\d-]+)\&',
      caseSensitive: false,
      multiLine: true,
    );
    RegExpMatch? match = exp.firstMatch(response.data);

    try {
      _searchToken = match?[1] as String;
      return _searchToken;
    } catch (e) {
      _logger.e('failed to get DuckDuckGo search token: ${e.runtimeType}');
    }
    return '';
  }

  Future<List<DuckWebImage>> fetchImages(
    String query, {
    DuckWebImageSize size = DuckWebImageSize.medium,
    DuckWebImageLayout layout = DuckWebImageLayout.wide,
    DuckWebImageType type = DuckWebImageType.photo,
    int imagesToReturn = maxImagesToReturn,
  }) async {
    /// Need to add a check to see if we get an unauthorized request because that will mean the token is expired, then we should get a new one
    final String? token = await _getDuckDuckGoSearchToken(query);
    if (token == null) {
      _logger.e('failed to get DuckDuckGo search token. Cannot search for images');
      return <DuckWebImage>[];
    }

    /// These filters specify what kind of images we will get
    final String filters =
        'size:${utils.getImageSizeFilter(size)},type:${utils.getImageTypeFilter(type)},layout:${utils.getImageLayoutFilter(layout)}';

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
    final String imageRequestUrl = "${utils.baseUrl}i.js";

    final Response response;
    try {
      response = await _dioService.get(imageRequestUrl, headers: utils.headers, parameters: params);
    } catch (e) {
      _logger.e('failed to fetch images: query: $query - error: ${e.runtimeType}');
      return <DuckWebImage>[];
    }
    if (response.statusCode != 200) {
      _logger.e('bad response: ${response.statusCode}');
      return <DuckWebImage>[];
    }

    Map data = json.decode(response.data);
    List<dynamic> results = data['results'];
    return utils.getImagesFromResponse(results, imagesToReturn);
  }
}
