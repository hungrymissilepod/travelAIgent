import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/attraction_model.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';
import 'package:travel_aigent/models/flexible_destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/airport_service.dart';
import 'package:travel_aigent/services/analytics_service.dart';
import 'package:travel_aigent/services/duck_duck_go_image_scraper_service/duck_duck_go_image_scraper_service.dart';
import 'package:travel_aigent/services/wikipedia_scraper_service.dart';
import 'package:uuid/uuid.dart';

class GeneratorService {
  final DuckDuckGoImageScraperService _duckDuckGoImageScraperService = locator<DuckDuckGoImageScraperService>();
  final WikipediaScraperService _wikipediaScraperService = locator<WikipediaScraperService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final AirportService _airportService = locator<AirportService>();
  final AiService _aiService = locator<AiService>();
  final Logger _logger = getLogger('GeneratorService');

  final Uuid uuid = const Uuid();

  late Destination _destination;
  late Preferences _preferences;

  final List<String> _blacklistedCities = <String>[];

  void setDestination(Destination destination) {
    _destination = destination;
    _logger.i('setDestination: ${_destination.toString()}');
  }

  void setPreferences(Preferences preferences) {
    _preferences = preferences;
    _logger.i('setPreferences: ${_preferences.toString()}');
  }

  void addToBlacklistedCities(String city) {
    _blacklistedCities.add(city);
    _logger.i('addToBlacklistedCities: $city');
  }

  void clearBlackList() {
    _blacklistedCities.clear();
    _logger.i('clearBlackList');
  }

  String get _blacklistPrompt {
    if (_blacklistedCities.isNotEmpty) {
      final String cities = _blacklistedCities.join(', ');
      return ' that is not $cities';
    }
    return '';
  }

  /// TODO: in future we should pass in the country name of the suggestion tapped.
  /// This will help for more accurate results in case there are multiple cities with that name
  /// ie. London (UK) and London (Canada). Barcelona (Spain) and Barcelona (Venezuela)
  String get _destinationPrompt {
    final String? flexibleDestination = _flexibleDestination(_destination.to);
    if (flexibleDestination != null) {
      if (flexibleDestination == anywhere) {
        return 'anywhere in the world';
      } else {
        /// Example: 'anywhere in Europe'
        return 'anywhere in $flexibleDestination';
      }
    }
    return 'in ${_destination.to}';
  }

  /// Checks if user has selected a [FlexibleDestination] and returns its name
  String? _flexibleDestination(String destination) {
    for (FlexibleDestination f in _airportService.airportData.flexibleDestinations) {
      if (f.name == destination) {
        return f.name;
      }
    }
    return null;
  }

  String get _attractionCount {
    return '5';
  }

  String get _attractionTypes {
    return _preferences.interests.join(', ');
  }

  /// The month range for weather data
  String get _month {
    String fromMonth = DateFormat('MMMM').format(_destination.fromDate);
    String toMonth = DateFormat('MMMM').format(_destination.toDate);
    if (fromMonth == toMonth) {
      return fromMonth;
    }
    return '$fromMonth to $toMonth';
  }

  /// TODO: GPT doens't seem very good at getting [distanceHours] correct. Maybe change this to display timezone instead?
  Future<Plan> generatePlan() async {
    _logGeneratePlanEndStart();

    final String prompt = '''
    Give me a random destination for a ${_preferences.holidayType} holiday $_destinationPrompt$_blacklistPrompt,
    a 5 sentence paragraph about the destination,
    the top $_attractionCount attractions in this place for people interested in $_attractionTypes with a 2-3 sentence description of each,
    and what kind of attraction it is,
    and a rating out of 5, the average temperature for $_month in celcius degrees (numbers range only),
    the distance in hours by airplane from ${_destination.from} as an int,
    the native language of the country, the coutry's currency code, as if you are a travel agent.
    If you want to use quotations please use single quotes.
    Respond in this JSON format:{"city":"city", "country":"country", "description":"description", "temperature": "temperature", "distance":distance, "language":"language", "currencyCode": "currencyCode", "attractions":[{"name":"name","description":"description","type":"type", "rating":rating}]}
    ''';

    _logger.i('prompt: $prompt');

    try {
      final String response = await _aiService.request(prompt, 700);
      _logger.i(response);

      Plan plan = Plan.fromJson(json.decode(response));
      plan.id = uuid.v4();
      return plan;
    } catch (e) {
      throw Exception('Failed to generate plan');
    }
  }

  Future<Plan> fetchImages(Plan plan) async {
    List<Future<dynamic>> futures = <Future<dynamic>>[
      _fetchPlanImageUrlsDuckDuckGo(plan),
      _fetchImagesForAttractions(plan.attractions, plan),
    ];

    await Future.wait(futures);

    plan.images = await futures[0];
    plan.attractions = await futures[1];

    plan.destination = _destination;
    plan.preferences = _preferences;
    _logGeneratePlanEndEvent(plan);
    return plan;
  }

  /// Fetches a list of images from DuckDuckGo for the plan
  Future<List<DuckWebImage>> _fetchPlanImageUrlsDuckDuckGo(Plan plan) async {
    final String query = '${plan.city}, ${plan.country}';
    List<DuckWebImage> images = await _duckDuckGoImageScraperService.getImages(query, imagesToReturn: 1);
    return images;
  }

  /// Fetches a list of images from DuckDuckGo for each attraction
  Future<List<Attraction>> _fetchImagesForAttractions(List<Attraction> attractions, Plan plan) async {
    List<Future<List<DuckWebImage>>> futures =
        attractions.map((e) => _fetchAttractionImageUrlsDuckDuckGo(e, plan)).toList();
    await Future.wait(futures);
    for (int i = 0; i < attractions.length; i++) {
      attractions[i].images = await futures[i];
    }
    return attractions;
  }

  Future<List<DuckWebImage>> _fetchAttractionImageUrlsDuckDuckGo(Attraction attraction, Plan plan) async {
    final String query = '${attraction.name}, ${plan.city}';
    final List<DuckWebImage> images = await _duckDuckGoImageScraperService.getImages(query);
    return images;
  }

  @Deprecated('Wikipedia image scraper is no longer used as we have DuckDuckGo image scraper now')
  Future<String?> _fetchAttractionImageUrlWikipedia(Attraction attraction) async {
    return await _wikipediaScraperService.getImage(attraction.name);
  }

  void _logGeneratePlanEndStart() {
    _analyticsService.logEvent('GeneratePlanStart');
  }

  void _logGeneratePlanEndEvent(Plan plan) {
    int? numDays;
    if (plan.destination != null) {
      numDays = plan.destination!.toDate.difference(plan.destination!.fromDate).inDays;
    }
    _analyticsService.logEvent(
      'GeneratePlanEnd',
      parameters: {
        'from': plan.destination?.from,
        'to': plan.destination?.to,
        'numDays': numDays,
        'numTravellers': plan.destination?.travellers,
        'holidayType': plan.preferences?.holidayType,
        'interests': plan.preferences?.holidayType,
        'city': plan.city,
        'country': plan.country,
      },
    );
  }
}
