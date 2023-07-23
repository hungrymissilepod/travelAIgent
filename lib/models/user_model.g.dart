// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      $enumDecode(_$MeasurementSystemEnumMap, json['measurementSystem']),
      (json['plans'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'measurementSystem':
          _$MeasurementSystemEnumMap[instance.measurementSystem]!,
      'plans': instance.plans,
    };

const _$MeasurementSystemEnumMap = {
  MeasurementSystem.metric: 'metric',
  MeasurementSystem.imperial: 'imperial',
};
