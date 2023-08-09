// import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:html/dom.dart' as dom;
import 'package:travel_aigent/services/web_scraper_service.dart';

class WikipediaScraperService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final DioService _dioService = locator<DioService>();
  final Logger _logger = getLogger('WikipediaScraperService');

  final String _https = 'https:';
  final String _wikipediaBaseUrl = 'https://en.wikipedia.org/';

  /// TODO: is there a use case for getting smaller images from Wikipedia? Possibly for smaller UI elements?

  /// Searches for [searchTerm] on Wikipedia and tries to return with a large image url
  Future<String> getWikipediaLargeImageUrlFromSearch(String searchTerm) async {
    /// Search for article and get url of first search result
    final String articleUrl =
        await _getWikipediaFirstSearchResultUrl(searchTerm);
    if (articleUrl.isNotEmpty) {
      /// Go to article url, find image preview, and fetch large image url
      final String imagePreviewUrl =
          await _clickOnWikipediaArticleImagePreview(articleUrl);
      if (imagePreviewUrl.isNotEmpty) {
        /// Finally return with large image url
        return await _getWikipediaLargeImageUrl(imagePreviewUrl);
      }
    }
    return '';
  }

  /// Searches for [searchTerm] on Wikipedia and returns the url of the article.
  /// We assume that Wikipedia's search is good enough so will always return first search result.
  Future<String> _getWikipediaFirstSearchResultUrl(String searchTerm) async {
    _logger.i('searchTerm: $searchTerm');

    /// Do a search on Wikipedia for this [searchTerm] and convert the HTML using BeautifulSoup
    final String url =
        'https://en.wikipedia.org/w/index.php?fulltext=Search&search=$searchTerm&ns0=1';

    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);

    if (bs == null) {
      return '';
    }

    /// If Wikipedia found a matching article we will find this class [mw-search-exists]
    final Bs4Element? element = bs.find('p', class_: 'mw-search-exists');
    if (element != null) {
      try {
        /// Try to find a div with this class, this is the first article in the search results
        final String url =
            _getUrlFromElement(bs, 'div', 'mw-search-result-heading');
        return '$_wikipediaBaseUrl$url';
      } catch (e) {
        return '';
      }
    }

    /// If Wikipedia could not find a matching article, we can try getting the first article in the search results anyway
    else {
      final String url =
          _getUrlFromElement(bs, 'div', 'mw-search-result-heading');
      return '$_wikipediaBaseUrl$url';
    }
  }

  String _getUrlFromElement(BeautifulSoup bs, String name, String className) {
    final Bs4Element? firstArticle = bs.find(name, class_: className);
    final Bs4Element? firstLink = firstArticle?.children[0];
    final String url = firstLink?.attributes['href'] as String;
    return url;
  }

  /// Goes to [url], finds the [fullImageLink] [div] and returns with the image url
  Future<String> _getWikipediaLargeImageUrl(String url) async {
    _logger.i('url: $url');

    /// Go to this [url] and convert the HTML using BeautifulSoup
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);
    if (bs == null) {
      return '';
    }

    final Bs4Element? element = bs.find('div', class_: 'fullImageLink');
    if (element != null) {
      try {
        final String url = element.a?.img?.attributes['src'] as String;
        return _prependHttpsToUrl(url);
      } catch (e) {
        return '';
      }
    }
    return '';
  }

  /// Finds the first image preview in a Wikipedia article at [url].
  /// Returns a url to the larger image preview.
  Future<String> _clickOnWikipediaArticleImagePreview(String url) async {
    _logger.i('url: $url');

    /// Go to this [url] and convert the HTML using BeautifulSoup
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);
    if (bs == null) {
      return '';
    }

    final Bs4Element? element = bs.find('a', class_: 'mw-file-description');
    if (element != null) {
      try {
        final String url = element.attributes['href'] as String;
        return '$_wikipediaBaseUrl$url';
      } catch (e) {
        return '';
      }
    }
    return '';
  }

  String _prependHttpsToUrl(String url) {
    if (!url.contains(_https)) {
      return '$_https$url';
    }
    return url;
  }

  /// Gets the small preview image from wikipedia article
  @Deprecated('Old version of doing this before using BeautifulSoup')
  Future<String> getWikipediaImageSmall(String searchTerm) async {
    _logger.i('searchTerm: $searchTerm');

    /// Fetch html of wikipedia page based on search term
    final response = await _dioService
        .get('https://en.wikipedia.org/wiki/$searchTerm', printResponse: false);
    dom.Document html = dom.Document.html(response.data);

    /// Select all images from the page
    final urlImages = html
        .querySelectorAll('div.thumbimage > span > a > img')
        .map((e) => e.attributes['src'])
        .toList();

    /// Get the first image in the page (will be what the article is about)
    String imageUrl = urlImages.first ?? '';
    imageUrl = _prependHttpsToUrl(imageUrl);
    _logger.i('image: $imageUrl');
    return imageUrl;
  }

  /// Gets the full size version of wikipedia preview image
  @Deprecated('Old version of doing this before using BeautifulSoup')
  Future<String> getWikipediaImageLarge(String searchTerm) async {
    _logger.i('searchTerm: $searchTerm');

    /// First get the smaller image from the wikipedia page for this search term
    final response = await _dioService
        .get('https://en.wikipedia.org/wiki/$searchTerm', printResponse: false);
    dom.Document html = dom.Document.html(response.data);

    /// Get link to the full size version of the thumbnail image
    final urlImages = html
        .querySelectorAll('div.thumbimage > span > a')
        .map((e) => e.attributes['href'])
        .toList();

    /// Get the html from this fullsize image page
    String fullsizeImageUrl = 'https://en.wikipedia.org${urlImages.first}';
    final response2 =
        await _dioService.get(fullsizeImageUrl, printResponse: false);
    dom.Document html2 = dom.Document.html(response2.data);

    /// Get link to the full size image
    final urlImages2 = html2
        .querySelectorAll('div.mw-filepage-resolutioninfo > a')
        .map((e) => e.attributes['href'])
        .toList();

    String imageUrl = urlImages2.first ?? '';
    imageUrl = _prependHttpsToUrl(imageUrl);
    _logger.i('image: $imageUrl');
    return imageUrl;
  }
}
