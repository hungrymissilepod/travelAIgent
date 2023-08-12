import 'package:json_annotation/json_annotation.dart';

part 'duck_web_image_model.g.dart';

/// Image scraped from DuckDuckGo
@JsonSerializable()
class DuckWebImage {
  final String image;
  final String thumbnail;

  DuckWebImage(this.image, this.thumbnail);

  factory DuckWebImage.fromJson(Map<String, dynamic> json) => _$DuckWebImageFromJson(json);

  Map<String, dynamic> toJson() => _$DuckWebImageToJson(this);
}
