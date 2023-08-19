import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';

part 'airport_data_model.g.dart';

@JsonSerializable()
class AirportData extends Equatable {
  final List<Airport> airports;
  final List<Country> countries;
  final List<City> cities;
  final List<FlexibleDestination> flexibleDestinations;

  const AirportData(this.airports, this.countries, this.cities, this.flexibleDestinations);

  factory AirportData.fromJson(Map<String, dynamic> json) => _$AirportDataFromJson(json);

  Map<String, dynamic> toJson() => _$AirportDataToJson(this);

  @override
  List<Object?> get props => <Object?>[airports, countries, cities, flexibleDestinations];
}
