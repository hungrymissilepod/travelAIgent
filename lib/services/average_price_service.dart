import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/dio_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

class AveragePriceService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final DioService dioService = locator<DioService>();
  final Logger _logger = getLogger('CurrencyScraperService');

  Future<Map<String, dynamic>?> fetchAveragePrices(String city, String country) async {
    /// First try to get prices for [city]
    List<double>? prices = await _fetchPricesForCity(city);

    /// If we fail, try to get prices for [country]
    if (prices == null) {
      _logger.e('Failed to get prices for city: $city');
      prices = await _fetchPricesForCountry(country);
    }

    if (prices == null) {
      _logger.e('Failed to get prices for country and city: $city, $country');
      return null;
    }

    return <String, dynamic>{'beer': prices[0], 'dinner': prices[1], 'capuccino': prices[2]};
  }

  Future<List<double>?> _fetchPricesForCity(String city) async {
    city = _sanitiseDestination(city);
    final String url = 'https://www.expatistan.com/cost-of-living/$city';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);
    return await _fetchPricesFromBeautifulSoup(bs);
  }

  Future<List<double>?> _fetchPricesForCountry(String country) async {
    country = _sanitiseDestination(country);
    final String url = 'https://www.expatistan.com/cost-of-living/country/$country';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);
    return await _fetchPricesFromBeautifulSoup(bs);
  }

  Future<List<double>?> _fetchPricesFromBeautifulSoup(BeautifulSoup? bs) async {
    final double? beerPrice = _getItemPrice(bs, 'beer');
    final double? dinnerPrice = _getItemPrice(bs, 'dinner');
    final double? capuccinoPrice = _getItemPrice(bs, 'capuccino');

    if (beerPrice == null || capuccinoPrice == null || dinnerPrice == null) {
      return null;
    }
    return <double>[beerPrice, dinnerPrice, capuccinoPrice];
  }

  double? _getItemPrice(BeautifulSoup? bs, String item) {
    final Bs4Element? beerIcon = bs?.find('td', class_: 'icon item-icon-sprite item-icon-sprite-$item');
    final Bs4Element? beerPrice = beerIcon?.findNextSibling('td')?.findNextSibling('td');
    return _webScraperService.sanitisePrice(beerPrice?.text, decimalPlaces: 2);
  }

  /// Need to sanitise the [destination] string for the [expatistan.com] website query
  String _sanitiseDestination(String destination) {
    return destination.replaceAll(' ', '-').toLowerCase();
  }
}
