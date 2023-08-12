import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/ip_location_model.dart';
import 'package:travel_aigent/services/dio_service.dart';

class IpService {
  final DioService _dioService = locator<DioService>();
  final Logger _logger = getLogger('IpService');

  IpLocation? ipLocation;

  Future<IpLocation?> getUserLocation() async {
    String apiKey = dotenv.env['IP_REGISTRY_API_KEY']!;
    String url =
        'https://api.ipregistry.co/?key=$apiKey&fields=location.country.name,location.country.code,location.city,currency.code,currency.symbol';
    Response response = await _dioService.get(url);
    if (response.data != null) {
      _logger.i(response.data);
      ipLocation = IpLocation.fromJson(response.data);
    }

    /// Edge case for chaning [Great Britain] to [United Kingdom]
    if (ipLocation?.countryCode == 'GB') {
      ipLocation?.countryCode = 'UK';
    }

    _logger.i('ipLocation - ${ipLocation?.city}, ${ipLocation?.country}, ${ipLocation?.currencyCode}');

    return ipLocation;
  }
}
