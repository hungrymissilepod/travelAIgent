// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airport _$AirportFromJson(Map<String, dynamic> json) => Airport(
      json['airportName'] as String,
      json['airportIataCode'] as String,
      json['countryName'] as String,
      json['countryIsoCode'] as String,
      json['continent'] as String,
      json['cityName'] as String?,
    );

Map<String, dynamic> _$AirportToJson(Airport instance) => <String, dynamic>{
      'airportName': instance.airportName,
      'airportIataCode': instance.airportIataCode,
      'countryName': instance.countryName,
      'countryIsoCode': instance.countryIsoCode,
      'continent': instance.continent,
      'cityName': instance.cityName,
    };
