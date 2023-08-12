import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/services/ip_service.dart';

class AirportService {
  final IpService _ipService = locator<IpService>();

  late AirportData airportData;

  /// The default value in the From field in [HomeView]
  String defaultFromValue = '';

  /// We want to find the closest airport to the user based on their location
  void getDefaultFromValue() {
    List<Airport> localAirports = <Airport>[];
    String userCountryCode = _ipService.ipLocation?.countryCode ?? '';
    String userCountry = _ipService.ipLocation?.country ?? '';
    String userCity = _ipService.ipLocation?.city ?? '';

    /// Get all airports that are in the same country as the user
    localAirports.addAll(
        airportData.airports.where((e) => e.countryIsoCode == userCountryCode));

    /// If we cannot find any local airports then default to the users country
    if (localAirports.isEmpty) {
      defaultFromValue = userCountry;
    }

    List<String> localAirportsNames =
        localAirports.map((e) => e.airportName).toList();

    ExtractedResult result = extractOne(
      query: userCity,
      choices: localAirportsNames,
      getter: (obj) => obj,
    );

    defaultFromValue = result.choice;
  }

  Future<void> loadAirports() async {
    String data = await rootBundle.loadString("assets/airport_data.json");
    final jsonResult = jsonDecode(data);
    airportData = AirportData.fromJson(jsonResult);
  }
}
