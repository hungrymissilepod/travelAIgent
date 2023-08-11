import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/country_model.dart';

part 'airport_data_model.g.dart';

@JsonSerializable()
class AirportData {
  List<Airport> airports;
  List<Country> countries;

  AirportData(this.airports, this.countries);

  factory AirportData.fromJson(Map<String, dynamic> json) => _$AirportDataFromJson(json);

  Map<String, dynamic> toJson() => _$AirportDataToJson(this);
}
