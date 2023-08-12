import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'country_model.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final String country;
  final String? capital;
  final String code;

  const Country(
    this.country,
    this.capital,
    this.code,
  );

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => <Object?>[country, capital, code];
}
