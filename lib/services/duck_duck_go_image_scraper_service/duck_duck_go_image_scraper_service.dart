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

  final List<String> _urls = <String>[
    'https://fetchduckimages0-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages1-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages2-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages3-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages4-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages5-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages6-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages7-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages8-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages9-kzcns5ex5a-uc.a.run.app',
    'https://fetchduckimages10-kzcns5ex5a-uc.a.run.app',
  ];

  int _proxy = 0;

  Future<List<DuckWebImage>> getImages(String query, {int imagesToReturn = maxImagesToReturn}) async {
    List<DuckWebImage> images = <DuckWebImage>[];

    _proxy = Random().nextInt(_urls.length);
    _logger.i('getImages - proxy: $_proxy');
    images = await _fetchImagesCloud(query, _urls[_proxy], imagesToReturn);

    return images;
  }

  /// Jake: I have disabled fetching images locally because it feels safer to do it on a
  /// proxy function rather than the users device
  Future<List<DuckWebImage>> _fetchImagesLocally(String query, int imagesToReturn) async {
    _logger.i('_fetchImagesLocally: query: $query - maxImagesToReturn: $maxImagesToReturn');
    return _localScraper.fetchImages(query, imagesToReturn: maxImagesToReturn);
  }

  Future<List<DuckWebImage>> _fetchImagesCloud(String query, String url, int imagesToReturn) async {
    _logger.i('_fetchImagesCloud: query: $query - url: $url - maxImagesToReturn: $maxImagesToReturn');
    return _cloudScraper.fetchImages(query, url, imagesToReturn: maxImagesToReturn);
  }
}
