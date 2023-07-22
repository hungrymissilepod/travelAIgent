import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

class GeneratorService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final AiService _aiService = locator<AiService>();
  final Logger _logger = getLogger('GeneratorService');

  late DestinationModel _destination;
  late PreferencesModel _preferences;

  void setDestination(DestinationModel destination) {
    _destination = destination;
    _logger.i('setDestination: ${_destination.toString()}');
  }

  void setPreferences(PreferencesModel preferences) {
    _preferences = preferences;
    _logger.i('setPreferences: ${_preferences.toString()}');
  }

  /// Testing generating a list of places and getting images for them
  // void init() async {
  // setBusy(true);
  // final String city = 'London';
  // final String places = await _aiService.request(
  //     'Give me a list of 3 famous attractions in ${city}. Respond as a plain csv without numbering.', 30);
  // print('places: $places');

  // final List<String> placeList = places.split(',');
  // for (String place in placeList) {
  //   print(place);
  //   String url = await _webScraperService.getWikipediaLargeImageUrlFromSearch(place);
  //   imageUrls.add(url);
  // }
  // setBusy(false);
  // }
}
