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
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'description': instance.description,
      'temperature': instance.temperature,
      'distance': instance.distance,
      'language': instance.language,
      'attractions': instance.attractions,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
    };
