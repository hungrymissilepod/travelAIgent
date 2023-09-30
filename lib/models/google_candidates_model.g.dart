// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_candidates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleCandidates _$GoogleCandidatesFromJson(Map<String, dynamic> json) =>
    GoogleCandidates(
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => GooglePlace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleCandidatesToJson(GoogleCandidates instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
    };
