import 'dart:math';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';
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
    'https://fetchduckimages4-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages5-kzcns5ex5a-uc.a.run.app',
  ];

  /// This is our solution for rotating proxy.
  /// We rotate through all cloud function apps and the local device
  void _incrementProxy() {
    proxy = Random().nextInt(urls.length + 1);
  }

  Future<List<DuckWebImage>> getImages(String query, {int imagesToReturn = maxImagesToReturn}) async {
    List<DuckWebImage> images = <DuckWebImage>[];
    _logger.i('getImages - proxy: $proxy');

    /// While developing use cloud functions so device does not get blocked
    // if (kDebugMode) {
    //   proxy = Random().nextInt(3);
    //   images = await _fetchImagesCloud(query, urls[proxy], imagesToReturn);
    // } else {
    //   if (proxy == 0) {
    //     images = await _fetchImagesLocally(query, imagesToReturn);
    //   } else {
    //     images = await _fetchImagesCloud(query, urls[proxy], imagesToReturn);
    //   }
    //   _incrementProxy();
    // }

    proxy = Random().nextInt(urls.length);
    images = await _fetchImagesCloud(query, urls[proxy], imagesToReturn);

    return images;
  }

  Future<List<DuckWebImage>> _fetchImagesLocally(String query, int imagesToReturn) async {
    _logger.i('_fetchImagesLocally: query: $query - maxImagesToReturn: $maxImagesToReturn');
    return _localScraper.fetchImages(query, imagesToReturn: maxImagesToReturn);
  }

  Future<List<DuckWebImage>> _fetchImagesCloud(String query, String url, int imagesToReturn) async {
    _logger.i('_fetchImagesCloud: query: $query - url: $url - maxImagesToReturn: $maxImagesToReturn');
    return _cloudScraper.fetchImages(query, url, imagesToReturn: maxImagesToReturn);
  }
}
