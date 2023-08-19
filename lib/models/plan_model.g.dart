// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      json['city'] as String,
      json['country'] as String,
      json['description'] as String,
      json['temperature'] as String,
      json['distance'] as int,
      json['language'] as String,
      (json['attractions'] as List<dynamic>)
          .map((e) => Attraction.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['destination'] == null
          ? null
          : Destination.fromJson(json['destination'] as Map<String, dynamic>),
      json['preferences'] == null
          ? null
          : Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => DuckWebImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      currencyCode: json['currencyCode'] as String?,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'description': instance.description,
      'temperature': instance.temperature,
      'distance': instance.distance,
      'language': instance.language,
      'attractions': instance.attractions.map((e) => e.toJson()).toList(),
      'destination': instance.destination?.toJson(),
      'preferences': instance.preferences?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'currencyCode': instance.currencyCode,
    };
