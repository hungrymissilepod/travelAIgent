import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:travel_aigent/services/duck_duck_go_utils.dart';

class DuckDuckGoCloudImageScraper {
  final Logger _logger = getLogger('DuckDuckGoCloudImageScraper');
  final DioService _dioService = locator<DioService>();
  final DuckDuckGoUtils utils = DuckDuckGoUtils();

  Future<List<String>> fetchImages(
    String query,
    String url, {
    DuckWebImageSize size = DuckWebImageSize.medium,
    DuckWebImageLayout layout = DuckWebImageLayout.wide,
    DuckWebImageType type = DuckWebImageType.photo,
    int imagesToReturn = maxImagesToReturn,
  }) async {
    final Response response = await _dioService.get(
      url,
      headers: utils.headers,
      parameters: {
        'q': query,
        'size': utils.getImageSizeFilter(size),
        'layout': utils.getImageLayoutFilter(layout),
        'type': utils.getImageTypeFilter(type),
      },
    );

    if (response.statusCode != 200) {
      _logger.e('bad response from cloud: ${response.statusCode}');
      return <String>[];
    }

    /// [results] is returned as a [Map] so we do not need to decode it
    List<dynamic> results = response.data['results'];
    return utils.getImagesFromResponse(results, imagesToReturn);
  }
}
