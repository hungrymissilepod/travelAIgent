import 'package:html/dom.dart' as dom;
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/dio_service.dart';

class WebScraperService {
  final _dioService = locator<DioService>();
  final _logger = getLogger('StartupViewModel');

  /// Gets the small preview image from wikipedia article
  Future<String> getWikipediaImageSmall(String searchTerm) async {
    _logger.i('searchTerm: $searchTerm');

    /// Fetch html of wikipedia page based on search term
    final response =
        await _dioService.get('https://en.wikipedia.org/wiki/$searchTerm');
    dom.Document html = dom.Document.html(response.data);

    /// Select all images from the page
    final urlImages = html
        .querySelectorAll('div.thumbimage > span > a > img')
        .map((e) => e.attributes['src'])
        .toList();

    /// Get the first image in the page (will be what the article is about)
    String imageUrl = urlImages.first ?? '';
    if (!imageUrl.contains('https')) {
      imageUrl = 'https:$imageUrl';
    }
    _logger.i('image: $imageUrl');
    return imageUrl;
  }

  /// Gets the full size version of wikipedia preview image
  Future<String> getWikipediaImageLarge(String searchTerm) async {
    _logger.i('searchTerm: $searchTerm');

    /// First get the smaller image from the wikipedia page for this search term
    final response =
        await _dioService.get('https://en.wikipedia.org/wiki/$searchTerm');
    dom.Document html = dom.Document.html(response.data);

    /// Get link to the full size version of the thumbnail image
    final urlImages = html
        .querySelectorAll('div.thumbimage > span > a')
        .map((e) => e.attributes['href'])
        .toList();

    /// Get the html from this fullsize image page
    String fullsizeImageUrl = 'https://en.wikipedia.org${urlImages.first}';
    final response2 = await _dioService.get(fullsizeImageUrl);
    dom.Document html2 = dom.Document.html(response2.data);

    /// Get link to the full size image
    final urlImages2 = html2
        .querySelectorAll('div.mw-filepage-resolutioninfo > a')
        .map((e) => e.attributes['href'])
        .toList();

    String imageUrl = urlImages2.first ?? '';
    if (!imageUrl.contains('https')) {
      imageUrl = 'https:$imageUrl';
    }
    _logger.i('image: $imageUrl');
    return imageUrl;
  }
}
