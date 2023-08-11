// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpLocation _$IpLocationFromJson(Map<String, dynamic> json) => IpLocation(
      json['country'] as String,
      json['city'] as String,
      json['currencyCode'] as String,
      json['currencySymbol'] as String,
    );

Map<String, dynamic> _$IpLocationToJson(IpLocation instance) =>
    <String, dynamic>{
      'country': instance.country,
      'city': instance.city,
      'currencyCode': instance.currencyCode,
      'currencySymbol': instance.currencySymbol,
    };
