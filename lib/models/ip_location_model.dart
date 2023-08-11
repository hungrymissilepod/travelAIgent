import 'package:json_annotation/json_annotation.dart';

part 'ip_location_model.g.dart';

@JsonSerializable()
class IpLocation {
  String country;
  String city;
  String currencyCode;
  String currencySymbol;

  IpLocation(this.country, this.city, this.currencyCode, this.currencySymbol);

  factory IpLocation.fromJson(Map<String, dynamic> json) {
    return IpLocation(
      json['location']['country']['name'],
      json['location']['city'],
      json['currency']['code'],
      json['currency']['symbol'],
    );
  }

  Map<String, dynamic> toJson() => _$IpLocationToJson(this);
}
