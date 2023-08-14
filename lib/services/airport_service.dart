import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/services/ip_service.dart';

class AirportService {
  final IpService _ipService = locator<IpService>();
  final Logger _logger = getLogger('AirportService');

  late AirportData airportData;

  /// The default value in the From field in [HomeView]
  String defaultFromValue = '';

  /// We want to find the closest airport to the user based on their location
  void getDefaultFromValue() {
    List<Airport> localAirports = <Airport>[];
    String userCountryCode = _ipService.ipLocation?.countryCode ?? '';
    String userCountry = _ipService.ipLocation?.country ?? '';
    String userCity = _ipService.ipLocation?.city ?? '';
    _logger.i('countryCode: $userCountryCode - userCountry: $userCountry - userCity: $userCity');

    /// Get all airports that are in the same country as the user
    localAirports.addAll(airportData.airports.where((e) => e.countryIsoCode == userCountryCode));

    /// If we cannot find any local airports then default to the users country
    if (localAirports.isEmpty) {
      defaultFromValue = userCountry;
      _logger.i('cannot find local airport, defaulting to user country: $defaultFromValue');
      return;
    }

    List<String> localAirportsNames = localAirports.map((e) => e.airportName).toList();

    try {
      ExtractedResult result = extractOne(
        query: userCity,
        cutoff: 60,
        choices: localAirportsNames,
        getter: (obj) => obj,
      );
      defaultFromValue = result.choice;
      _logger.i('best airport we could find: $defaultFromValue');
    } catch (e) {
      defaultFromValue = userCountry;
      _logger.i('cannot find close enough airport. defaulting to country');
    }
  }

  Future<void> loadAirports() async {
    String data = await rootBundle.loadString("assets/airport_data.json");
    final jsonResult = jsonDecode(data);
    airportData = AirportData.fromJson(jsonResult);
  }
}
