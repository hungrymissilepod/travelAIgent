class IpLocation {
  String country;
  String city;
  String currencyCode;

  IpLocation(this.country, this.city, this.currencyCode);

  factory IpLocation.fromJson(Map<String, dynamic> json) {
    return IpLocation(
      json['location']['country']['name'],
      json['location']['city'],
      json['currency']['code'],
    );
  }
}
