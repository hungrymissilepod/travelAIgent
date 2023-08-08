class IpLocation {
  String country;
  String city;

  IpLocation(this.country, this.city);

  factory IpLocation.fromJson(Map<String, dynamic> json) {
    return IpLocation(
      json['location']['country']['name'],
      json['location']['city'],
    );
  }
}
