import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/misc/weather_converter.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class AtAGlaceSectionViewModel extends BaseViewModel {
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  late final Plan? plan;
  late final Destination? destination;

  AtAGlaceSectionViewModel(Plan? p, Destination? d) {
    plan = p;
    destination = d;
  }

  /// TODO: add ability to change to farenheit
  /// TODO: display weather in appropriate system. Will need to calculate farenheit from celcius
  final String celciusChar = '°C';

  String get locationLabel {
    return '${plan?.city}, ${plan?.country}';
  }

  String get dateLabel {
    return '${destination?.fromDate.datePickerFormat()} - ${destination?.toDate.datePickerFormat()}';
  }

  String get distanceLavel {
    return '${plan?.distance} ${_getDistanceString()}';
  }

  String get travellersLabel {
    return '${destination?.travellers} ${_getTravellerString()}';
  }

  /// By default we always get temperature in Celcius
  String weatherLabel() {
    String temperatureRange = '';

    /// Check if we need to convert temperature from Celcius to Farenheit
    if (_whoAmIService.whoAmI.measurementSystem == MeasurementSystem.imperial) {
      // return celciusRangeToFarenheitRange(plan?.temperature ?? '');
      temperatureRange = celciusRangeToFarenheitRange(plan?.temperature ?? '');
    } else {
      temperatureRange = '${plan?.temperature}';
    }
    return '$temperatureRange${_getTemperatureString()}';
  }

  String get languageLabel {
    return '${plan?.language}';
  }

  String _getTravellerString() {
    if (destination?.travellers == 1) {
      return 'traveller';
    }
    return 'travellers';
  }

  String _getDistanceString() {
    if (plan?.distance == 1) {
      return 'hour away';
    }
    return 'hours away';
  }

  /// Compares the [fromDate] and [toDate] months and returns a String
  /// used in displaying average temperature
  String _getTemperatureString() {
    String fromMonth =
        DateFormat('MMM').format(destination?.fromDate ?? DateTime.now());
    String toMonth =
        DateFormat('MMM').format(destination?.toDate ?? DateTime.now());
    if (fromMonth == toMonth) {
      return '$celciusChar in $fromMonth';
    }
    return '$celciusChar in $fromMonth - $toMonth';
  }
}
