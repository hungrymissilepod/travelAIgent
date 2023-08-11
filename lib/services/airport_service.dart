import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:travel_aigent/models/airport_data_model.dart';

class AirportService {
  late AirportData airportData;

  Future<void> loadAirports() async {
    String data = await rootBundle.loadString("assets/airport_data.json");
    final jsonResult = jsonDecode(data);
    airportData = AirportData.fromJson(jsonResult);
  }
}
