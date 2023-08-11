import 'package:json_annotation/json_annotation.dart';

part 'airport_model.g.dart';

@JsonSerializable()
class Airport {
  String airportName;
  String airportIataCode;
  String countryName;
  String countryIsoCode;
  String continent;
  String? cityName;

  Airport(this.airportName, this.airportIataCode, this.countryName, this.countryIsoCode, this.continent, this.cityName);

  factory Airport.fromJson(Map<String, dynamic> json) => _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);
}
