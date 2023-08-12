import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'city_model.g.dart';

@JsonSerializable()
class City extends Equatable {
  final String country;
  final String city;

  /// Country code
  final String code;
  final bool isCapital;

  const City(
    this.country,
    this.city,
    this.code,
    this.isCapital,
  );

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object?> get props => <Object?>[country, city, code, isCapital];
}
