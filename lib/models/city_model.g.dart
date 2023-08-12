// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      json['country'] as String,
      json['city'] as String,
      json['code'] as String,
      json['isCapital'] as bool,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'code': instance.code,
      'isCapital': instance.isCapital,
    };
