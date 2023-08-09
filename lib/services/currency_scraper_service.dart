import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

class ExchangeRateData {
  double beerPrice;
  double mealPrice;
  double exchangeRate;

  ExchangeRateData(this.beerPrice, this.mealPrice, this.exchangeRate);
}

class CurrencyScraperService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final Logger _logger = getLogger('CurrencyScraperService');

  Future<ExchangeRateData?> fetchExchangeRateData(String destination, String fromCurrency, String toCurrency) async {
    if (destination == 'Anywhere' || fromCurrency.isEmpty || toCurrency.isEmpty) {
      _logger.e(
          'user selected Anywhere or fromCurrency or toCurrency are null: $destination - $fromCurrency - $toCurrency');
      return null;
    }

    /// TODO: use Wise to get exchange rate and be sure to get whole exchange rate for more accurate conversions
    final double? exchangeRate = await _fetchExchangeRate(fromCurrency, toCurrency);

    if (exchangeRate == null) {
      return null;
    }

    /// TODO: use future.wait to get exchange rate and average prices at same time
    /// TODO: if any of these values return as false then return null
    /// TODO: if this returns null then do NOT show any price data
    var map = await _fetchAveragePrices(destination);

    /// TODO: get prices of other things

    return ExchangeRateData(map?['beer'], 1.0, exchangeRate);
  }

  Future<Map<String, dynamic>?> _fetchAveragePrices(String destination) async {
    /// TODO: use Future.wait to fetch all this in one go
    double? beerPrice = await _fetchAverageBeerPrice(destination);
    print('beerPrice: $beerPrice');

    if (beerPrice == null) {
      return null;
    }
    return <String, dynamic>{'beer': beerPrice};
  }

  Future<double?> _fetchAverageBeerPrice(String destination) async {
    final String dest = destination.replaceAll(' ', '-').toLowerCase();
    final String beerPriceUrl = 'https://www.expatistan.com/price/beer/$dest';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(beerPriceUrl);

    final Bs4Element? compareHeading = bs?.find('h1', class_: 'compare');
    final Bs4Element? price = compareHeading?.find('span', class_: 'city-1');

    if (price == null) {
      return null;
    }
    return _sanitisePrice(price.text, decimalPlaces: 0);
  }

  Future<double?> _fetchExchangeRate(String fromCurrency, String toCurrency) async {
    final String url = 'https://www.xe.com/currencyconverter/convert/?Amount=1&From=$fromCurrency&To=$toCurrency';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);

    /// Find the faded digits on this page (these are the decimal places that we don't want)
    final Bs4Element? fadedDigits = bs?.find('span', class_: 'faded-digits');

    /// Get the exchange rate text from the parent class
    /// This will return something like [0.51331137 British Pounds]
    final Bs4Element? exchangeRate = fadedDigits?.parent;

    if (exchangeRate == null) {
      _logger.e('cannot find exchange rate');
      return null;
    }

    double? rate = _sanitisePrice(exchangeRate.text);
    _logger.i('exchangeRate: $rate');
    return rate;
  }

  /// Remove all other character from string, only leave the numbers
  double? _sanitisePrice(String str, {int decimalPlaces = 2}) {
    final String numbers = str.replaceAll(RegExp("[^0-9.]"), "");

    /// Parse the number to a double
    final double? longRate = double.tryParse(numbers);
    if (longRate == null) {
      _logger.e('failed to parse exchange rate to double: $numbers');
      return null;
    }

    /// Convert to string with 2 decimal places
    final String shortRate = longRate.toStringAsFixed(decimalPlaces);

    /// Finally convert back to double
    return double.tryParse(shortRate);
  }
}
