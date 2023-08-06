// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      json['holidayType'] as String,
      (json['interests'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'holidayType': instance.holidayType,
      'interests': instance.interests.toList(),
    };
