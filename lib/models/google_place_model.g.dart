// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePlace _$GooglePlaceFromJson(Map<String, dynamic> json) => GooglePlace(
      placeId: json['place_id'] as String,
      formattedAddress: json['formatted_address'] as String? ?? '',
      name: json['name'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$GooglePlaceToJson(GooglePlace instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'formatted_address': instance.formattedAddress,
      'name': instance.name,
      'rating': instance.rating,
    };
