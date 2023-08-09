import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/average_price_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

class ExchangeRateData {
  double beer;
  double dinner;
  double capuccino;
  double exchangeRate;

  /// Curreny code of country user is travelling from
  String fromCurrencyCode;

  /// Curreny code of country user is travelling to
  String toCurrencyCode;

  ExchangeRateData(
      this.beer, this.dinner, this.capuccino, this.exchangeRate, this.fromCurrencyCode, this.toCurrencyCode);
}

class CurrencyScraperService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final AveragePriceService _averagePriceService = locator<AveragePriceService>();
  final Logger _logger = getLogger('CurrencyScraperService');

  Future<ExchangeRateData?> fetchExchangeRateData(String destination, String fromCurrency, String toCurrency) async {
    if (destination == 'Anywhere' || fromCurrency.isEmpty || toCurrency.isEmpty) {
      _logger.e(
          'user selected Anywhere or fromCurrency or toCurrency are null: $destination - $fromCurrency - $toCurrency');
      return null;
    }

    List<Future<dynamic>> futures = <Future<dynamic>>[
      _fetchExchangeRate(fromCurrency, toCurrency),
      _averagePriceService.fetchAveragePrices(destination),
    ];

    await Future.wait(futures);

    final double? exchangeRate = await futures[0];
    final Map<String, dynamic>? prices = await futures[1];

    if (exchangeRate == null || prices == null) {
      return null;
    }

    return ExchangeRateData(
      prices['beer'],
      prices['dinner'],
      prices['capuccino'],
      exchangeRate,
      fromCurrency,
      toCurrency,
    );
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

    double? rate = _webScraperService.sanitisePrice(exchangeRate.text);
    _logger.i('exchangeRate: $rate');
    return rate;
  }
}
