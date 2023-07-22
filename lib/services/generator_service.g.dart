// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      json['city'] as String,
      (json['attractions'] as List<dynamic>)
          .map((e) => Attraction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'city': instance.city,
      'attractions': instance.attractions,
    };

Attraction _$AttractionFromJson(Map<String, dynamic> json) => Attraction(
      json['name'] as String,
      json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$AttractionToJson(Attraction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
