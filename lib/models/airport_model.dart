import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'airport_model.g.dart';

@JsonSerializable()
class Airport extends Equatable {
  final String airportName;
  final String airportIataCode;
  final String countryName;
  final String countryIsoCode;
  final String continent;
  final String? cityName;

  const Airport(this.airportName, this.airportIataCode, this.countryName,
      this.countryIsoCode, this.continent, this.cityName);

  factory Airport.fromJson(Map<String, dynamic> json) =>
      _$AirportFromJson(json);

  Map<String, dynamic> toJson() => _$AirportToJson(this);

  @override
  List<Object?> get props => <Object?>[
        airportName,
        airportIataCode,
        countryName,
        countryIsoCode,
        continent,
        cityName
      ];
}
