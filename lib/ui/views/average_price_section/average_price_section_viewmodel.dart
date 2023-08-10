import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/exchange_rate_data_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/currency_scraper_service.dart';
import 'package:travel_aigent/services/ip_service.dart';

class AveragePriceSectionViewModel extends BaseViewModel {
  final CurrencyScraperService _currencyScraperService =
      locator<CurrencyScraperService>();
  final IpService _ipService = locator<IpService>();
  final Logger _logger = getLogger('AveragePriceSectionViewModel');

  late ExchangeRateData? exchangeRateData;
  late final Plan? plan;

  String get currencyCode => _ipService.ipLocation?.currencyCode ?? '';

  Future<void> init(Plan? p) async {
    plan = p;
    _fetchExchangeRateData();
  }

  Future<void> _fetchExchangeRateData() async {
    _logger.i('_fetchExchangeRateData');
    exchangeRateData = await runBusyFuture(
      _currencyScraperService.fetchExchangeRateData(
        plan?.city ?? '',
        plan?.currencyCode ?? '',
        _ipService.ipLocation?.currencyCode ?? '',
      ),
    );
  }

  String get currencySymbol => _ipService.ipLocation?.currencySymbol ?? '';

  String get currencyConversionLabel {
    if (isBusy) return '';
    return '1 $currencyCode = ${_calculateExchangeInverse()} ${plan?.currencyCode}';
  }

  String get dinnerLabel {
    if (isBusy) return '';
    return 'Dinner for two $currencySymbol${_calculateItemPrice(exchangeRateData?.dinner)}';
  }

  String get beerLabel {
    if (isBusy) return '';
    return 'Pint of beer $currencySymbol${_calculateItemPrice(exchangeRateData?.beer)}';
  }

  String get coffeeLabel {
    if (isBusy) return '';
    return 'Capuccino $currencySymbol${_calculateItemPrice(exchangeRateData?.capuccino)}';
  }

  double? _calculateExchangeInverse() {
    double? exchangeRate = exchangeRateData?.exchangeRate;
    if (exchangeRate == null) return null;
    double? r = 1.0 / exchangeRate;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }

  double? _calculateItemPrice(double? item) {
    if (item == null) return null;
    double? r = item * exchangeRateData!.exchangeRate;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }
}
