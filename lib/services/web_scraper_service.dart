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
}
