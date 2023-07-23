// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination(
      json['from'] as String,
      json['to'] as String,
      DateTime.parse(json['fromDate'] as String),
      DateTime.parse(json['toDate'] as String),
      json['travellers'] as int,
    );

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'fromDate': instance.fromDate.toIso8601String(),
      'toDate': instance.toDate.toIso8601String(),
      'travellers': instance.travellers,
    };
