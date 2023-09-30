import 'package:json_annotation/json_annotation.dart';
import 'package:travel_aigent/models/google_place_model.dart';

part 'google_candidates_model.g.dart';

@JsonSerializable()
class GoogleCandidates {
  List<GooglePlace> candidates;

  GoogleCandidates({
    required this.candidates,
  });

  factory GoogleCandidates.fromJson(Map<String, dynamic> json) => _$GoogleCandidatesFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleCandidatesToJson(this);
}
