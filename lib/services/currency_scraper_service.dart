import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/exchange_rate_data_model.dart';
import 'package:travel_aigent/services/average_price_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

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
    final String url =
        'https://wise.com/gb/currency-converter/${fromCurrency.toLowerCase()}-to-${toCurrency.toLowerCase()}-rate?amount=1';
    final BeautifulSoup? bs = await _webScraperService.fetchBeautifulSoup(url);
    final Bs4Element? digits = bs?.find('span', class_: 'text-success');

    if (digits == null) {
      _logger.e('cannot find exchange rate');
      return null;
    }

    double? rate = _webScraperService.sanitisePrice(digits.text);
    _logger.i('exchangeRate: $rate');
    return rate;
  }
}
