import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

class AveragePriceService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final Logger _logger = getLogger('CurrencyScraperService');

  Future<Map<String, dynamic>?> fetchAveragePrices(String destination) async {
    List<Future<double?>> futures = <Future<double?>>[
      _fetchAverageBeerPrice(destination),
      _fetchAverageDinnerPrice(destination),
      _fetchAverageCapuccinoPrice(destination),
    ];

    await Future.wait(futures);

    final double? beer = await futures[0];
    final double? dinner = await futures[1];
    final double? capuccino = await futures[2];

    if (beer == null || dinner == null || capuccino == null) {
      _logger.e(
          'Failed to get averagePrices for something. beer: $beer - dinner: $dinner - capuccino: $capuccino');
      return null;
    }
    return <String, dynamic>{
      'beer': beer,
      'dinner': dinner,
      'capuccino': capuccino
    };
  }

  Future<double?> _fetchAverageBeerPrice(String destination) async {
    return _fetchAverageBeerForItem(destination, 'beer');
  }

  Future<double?> _fetchAverageDinnerPrice(String destination) async {
    return _fetchAverageBeerForItem(destination, 'dinner');
  }

  Future<double?> _fetchAverageCapuccinoPrice(String destination) async {
    return _fetchAverageBeerForItem(destination, 'capuccino');
  }

  Future<double?> _fetchAverageBeerForItem(
      String destination, String item) async {
    destination = _sanitiseDestination(destination);
    final String url = 'https://www.expatistan.com/price/$item/$destination';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);

    final Bs4Element? compareHeading = bs?.find('h1', class_: 'compare');
    final Bs4Element? price = compareHeading?.find('span', class_: 'city-1');

    if (price == null) {
      return null;
    }
    return _webScraperService.sanitisePrice(price.text, decimalPlaces: 2);
  }

  /// Need to sanitise the [destination] string for the [expatistan.com] website query
  String _sanitiseDestination(String destination) {
    return destination.replaceAll(' ', '-').toLowerCase();
  }
}
