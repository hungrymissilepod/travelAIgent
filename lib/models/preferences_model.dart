class PreferencesModel {
  final String holidayType;
  final List<String> interests;

  PreferencesModel(
    this.holidayType,
    this.interests,
  );

  @override
  String toString() => 'holidayType: $holidayType - interests: ${interests.toString()}';
}
