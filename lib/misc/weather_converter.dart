/// Converts a temperature range in celcius to farenheit
/// Example input: 18-23°C
String celciusRangeToFarenheitRange(String temperature) {
  if (temperature.isEmpty) return '';

  /// Sometimes we do not get a temperature range so we have to just calculate
  /// the single temperature value
  if (!temperature.contains('-')) {
    double celciusTemp = double.tryParse(temperature) ?? 0;
    double farenheitTemp = celciusToFarenheit(celciusTemp);
    return '${farenheitTemp.round()}';
  }

  List<String> celciusTemps = temperature.split('-');
  double fromCelciusTemp = double.tryParse(celciusTemps[0]) ?? 0;
  double toCelciusTemp = double.tryParse(celciusTemps[1]) ?? 0;

  double fromFarenheitTemp = celciusToFarenheit(fromCelciusTemp);
  double toFarenheightTemp = celciusToFarenheit(toCelciusTemp);
  return '${fromFarenheitTemp.round()} - ${toFarenheightTemp.round()}';
}

double celciusToFarenheit(double celcius) {
  return (celcius * 9 / 5) + 32;
}
