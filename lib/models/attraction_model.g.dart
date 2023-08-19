// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attraction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attraction _$AttractionFromJson(Map<String, dynamic> json) => Attraction(
      json['name'] as String,
      json['description'] as String,
      json['type'] as String,
      (json['rating'] as num).toDouble(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => DuckWebImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttractionToJson(Attraction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'rating': instance.rating,
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };
