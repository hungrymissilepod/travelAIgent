import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/dio_service.dart';

class WebScraperService {
  final DioService _dioService = locator<DioService>();
  final Logger _logger = getLogger('WebScraperService');

  Future<BeautifulSoup?> fetchBeautifulSoup(String url) async {
    final Response response = await _dioService.get(url, printResponse: false);
    if (response.data == null) {
      return null;
    }
    return BeautifulSoup(response.data);
  }

  /// Remove all other character from string, only leave the numbers
  double? sanitisePrice(String? str, {int decimalPlaces = 2}) {
    if (str == null) return null;

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
