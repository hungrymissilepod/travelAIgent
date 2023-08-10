import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/exchange_rate_data_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/currency_scraper_service.dart';
import 'package:travel_aigent/services/ip_service.dart';

class AveragePriceSectionViewModel extends BaseViewModel {
  final CurrencyScraperService _currencyScraperService = locator<CurrencyScraperService>();
  final IpService _ipService = locator<IpService>();
  final Logger _logger = getLogger('AveragePriceSectionViewModel');

  late ExchangeRateData? exchangeRateData;
  late final Plan? plan;

  String get currencyCode => _ipService.ipLocation?.currencyCode ?? '';

  Future<void> init(Plan? p, ExchangeRateData? e) async {
    plan = p;
    exchangeRateData = e;
    if (exchangeRateData == null) {
      _fetchExchangeRateData();
    }
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

  double? calculateExchangeInverse() {
    double? exchangeRate = exchangeRateData?.exchangeRate;
    if (exchangeRate == null) return null;
    double? r = 1.0 / exchangeRate;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }

  double? calculateItemPrice(double? item) {
    if (item == null) return null;
    double? r = item * exchangeRateData!.exchangeRate;
    String s = r.toStringAsFixed(2);
    return double.tryParse(s);
  }
}
