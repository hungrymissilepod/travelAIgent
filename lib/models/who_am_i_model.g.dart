// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'who_am_i_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WhoAmI _$WhoAmIFromJson(Map<String, dynamic> json) => WhoAmI(
      name: json['name'] as String?,
      measurementSystem: $enumDecodeNullable(
              _$MeasurementSystemEnumMap, json['measurementSystem']) ??
          MeasurementSystem.metric,
      plans: (json['plans'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WhoAmIToJson(WhoAmI instance) => <String, dynamic>{
      'name': instance.name,
      'measurementSystem':
          _$MeasurementSystemEnumMap[instance.measurementSystem]!,
      'plans': instance.plans,
    };

const _$MeasurementSystemEnumMap = {
  MeasurementSystem.metric: 'metric',
  MeasurementSystem.imperial: 'imperial',
};
