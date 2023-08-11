// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airport_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirportData _$AirportDataFromJson(Map<String, dynamic> json) => AirportData(
      (json['airports'] as List<dynamic>)
          .map((e) => Airport.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirportDataToJson(AirportData instance) =>
    <String, dynamic>{
      'airports': instance.airports,
      'countries': instance.countries,
    };
