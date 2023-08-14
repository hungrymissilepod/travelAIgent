import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/duck_duck_go_cloud_image_scraper.dart';
import 'package:travel_aigent/services/duck_duck_go_image_scraper_service/duck_duck_go_local_image_scraper.dart';
import 'package:travel_aigent/services/duck_duck_go_utils.dart';

class DuckDuckGoImageScraperService {
  final DuckDuckGoLocalImageScraper _localScraper = DuckDuckGoLocalImageScraper();
  final DuckDuckGoCloudImageScraper _cloudScraper = DuckDuckGoCloudImageScraper();
  final Logger _logger = getLogger('DuckDuckGoImageScraperService');

  int proxy = 0;

  final List<String> urls = <String>[
    'https://fetchduckimages1-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages2-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages3-kzcns5ex5a-uc.a.run.app',
  ];

  Future<List<String>> getImages(String query, {int imagesToReturn = maxImagesToReturn}) async {
    List<String> images = <String>[];
    _logger.i('getImages - proxy: $proxy');

    /// TODO: keep getting blocked while developing. I hope this does not happen in production!!!
    /// While developing just use cloud functions instead
    if (kDebugMode) {
      proxy = Random().nextInt(3);
      images = await _fetchImagesCloud(query, urls[proxy], imagesToReturn);
    } else {
      if (proxy == 0) {
        images = await _fetchImagesLocally(query, imagesToReturn);
      } else {
        images = await _fetchImagesCloud(query, urls[proxy], imagesToReturn);
      }
      _incrementProxy();
    }

    return images;
  }

  /// This is our solution for rotating proxy.
  /// We rotate through all cloud function apps and the local device
  void _incrementProxy() {
    proxy = Random().nextInt(4);
  }

  Future<List<String>> _fetchImagesLocally(String query, int imagesToReturn) async {
    _logger.i('_fetchImagesLocally: query: $query - maxImagesToReturn: $maxImagesToReturn');
    return _localScraper.fetchImages(query, imagesToReturn: maxImagesToReturn);
  }

  Future<List<String>> _fetchImagesCloud(String query, String url, int imagesToReturn) async {
    _logger.i('_fetchImagesCloud: query: $query - url: $url - maxImagesToReturn: $maxImagesToReturn');
    return _cloudScraper.fetchImages(query, url, imagesToReturn: maxImagesToReturn);
  }
}
