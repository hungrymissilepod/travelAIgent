import 'package:json_annotation/json_annotation.dart';

part 'preferences_model.g.dart';

@JsonSerializable()
class Preferences {
  final String holidayType;
  final Set<String> interests;

  Preferences(
    this.holidayType,
    this.interests,
  );

  @override
  String toString() => 'holidayType: $holidayType - interests: ${interests.toString()}';

  factory Preferences.fromJson(Map<String, dynamic> json) => _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}
