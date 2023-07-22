class DestinationModel {
  final String from;
  final String to;
  final bool checkedAnywhere;
  final double distanceHours;

  DestinationModel(
    this.from,
    this.to,
    this.checkedAnywhere,
    this.distanceHours,
  );

  @override
  String toString() => 'from: $from - to: $to - checkedAnywhere: $checkedAnywhere - distanceHours: $distanceHours';
}
