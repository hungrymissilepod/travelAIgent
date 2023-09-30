import 'package:json_annotation/json_annotation.dart';

part 'google_place_model.g.dart';

@JsonSerializable()
class GooglePlace {
  @JsonKey(name: 'place_id')
  String placeId;

  @JsonKey(name: 'formatted_address')
  String formattedAddress;

  String name;
  double rating;

  GooglePlace({
    required this.placeId,
    this.formattedAddress = '',
    this.name = '',
    this.rating = 0.0,
  });

  factory GooglePlace.fromJson(Map<String, dynamic> json) => _$GooglePlaceFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePlaceToJson(this);
}
