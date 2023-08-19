import 'package:travel_aigent/models/airport_data_model.dart';
import 'package:travel_aigent/models/airport_model.dart';
import 'package:travel_aigent/models/city_model.dart';
import 'package:travel_aigent/models/country_model.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';

class DestinationValidator {
  bool isValidSuggestion(AirportData data, String text) {
    final isValidFlexibleDestination = _isValidFlexibleDestination(data, text);
    if (isValidFlexibleDestination) return true;

    final isValidCountry = _isValidCountry(data, text);
    if (isValidCountry) return true;

    final isValidCity = _isValidCity(data, text);
    if (isValidCity) return true;

    final isValidAirport = _isValidAirport(data, text);
    if (isValidAirport) return true;

    return false;
  }

  bool _isValidCountry(AirportData data, String text) {
    for (Country c in data.countries) {
      if (c.country == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidCity(AirportData data, String text) {
    for (City c in data.cities) {
      if (c.city == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidAirport(AirportData data, String text) {
    for (Airport c in data.airports) {
      if (c.airportName == text) {
        return true;
      }
    }
    return false;
  }

  bool _isValidFlexibleDestination(AirportData data, String text) {
    for (FlexibleDestination c in data.flexibleDestinations) {
      if (c.name == text) {
        return true;
      }
    }
    return false;
  }
}
