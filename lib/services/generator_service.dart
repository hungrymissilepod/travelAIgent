import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

import 'package:json_annotation/json_annotation.dart';

// part 'plan.g.dart';
// part 'attraction.g.dart';

part 'generator_service.g.dart';

/*

Sample responses:
{"city":"Cape Town","attractions":[{"name":"Table Mountain","description":"majestic flat-topped mountain offering stunning views"},{"name":"Robben Island","description":"historic island where Nelson Mandela was imprisoned"},{"name":"Victoria & Alfred Waterfront","description":"vibrant waterfront with shops, restaurants, and entertainment"}]}

{"city":"Tokyo","attractions":[{"name":"Tokyo Tower","description":"Iconic communication tower with city views"},{"name":"Senso-ji Temple","description":"Oldest Buddhist temple in Tokyo"},{"name":"Shibuya Crossing","description":"Busiest pedestrian crossing in the world"}]}

{"city":"Rio de Janeiro","attractions":[{"name":"Christ the Redeemer","description":"Iconic statue overlooking the city"},{"name":"Copacabana Beach","description":"Vibrant beach known for its New Year's Eve celebrations"},{"name":"Sugarloaf Mountain","description":"Stunning granite peak offering panoramic views"}]}

{"city":"Berlin","attractions":[{"name":"Brandenburg Gate","description":"Iconic neoclassical monument and symbol of German reunification."},{"name":"Museum Island","description":"UNESCO World Heritage Site housing several renowned museums."},{"name":"Berlin Wall","description":"Historical landmark that divided the city for almost 30 years."}]}

{"city":"Krakow","attractions":[{"name":"Wawel Castle","description":"Medieval royal castle and cathedral"},{"name":"Main Market Square","description":"Historic square lined with colorful townhouses and the Cloth Hall"},{"name":"Auschwitz-Birkenau Memorial and Museum","description":"Infamous former Nazi concentration and extermination camp"}]}

{"city":"Krakow","attractions":[{"name":"Old Town","description":"Historical district with beautiful architecture and a lively atmosphere."},{"name":"Wawel Castle","description":"Impressive medieval royal residence with stunning views of the city."},{"name":"Auschwitz-Birkenau","description":"Infamous concentration camp-turned-memorial, serving as a stark reminder of the Holocaust."}]}

*/

// TODO: sometimes wikipedia responds with an iage called Question_book-svg.svg.
// If we return this DO NOT display it. Have to get image from TripAdvistor
// Or we need to make the wikipedia scraper smarter
// Is it possibly to query wikipedia for images rather than navigating the articles?

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

  Future<Plan> generatePlan2() async {
    final String place = 'Krakow';
    final String prompt =
        'Give me a famous city in $place and the top 3 attractions with a 1-3 second description. Respond in this JSON format:{"city":"city","attractions":[{"name":"name","description":"description"}]}';
    final String response = await _aiService.request(prompt, 200);
    print(response);

    Plan plan = Plan.fromJson(json.decode(response));
    print(plan.toString());
    for (Attraction attraction in plan.attractions) {
      String url = await _webScraperService.getWikipediaLargeImageUrlFromSearch(attraction.name);
      attraction.imageUrl = url;
    }

    return plan;
  }

  Future<Plan> generatePlan() async {
    final String city = 'London';
    final String attractionString = await _aiService.request(
        'Give me a list of 3 attractions in ${city}. Respond as plain CSV without numbering.', 30);
    print(attractionString);

    /// TODO: need to ENSURE that [attractions] is actually a CSV format before doing this
    List<String> attractionList = attractionString.split(',');
    List<Attraction> attractions = <Attraction>[];
    for (String a in attractionList) {
      String url = await _webScraperService.getWikipediaLargeImageUrlFromSearch(a);
      attractions.add(Attraction(a, 'description')..imageUrl = url);
    }

    Plan plan = Plan(city, attractions);
    return plan;
  }
}

@JsonSerializable()
class Plan {
  final String city;
  final List<Attraction> attractions;

  Plan(
    this.city,
    this.attractions,
  );

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class Attraction {
  final String name;
  final String description;
  String? imageUrl;

  Attraction(this.name, this.description, {this.imageUrl});

  factory Attraction.fromJson(Map<String, dynamic> json) => _$AttractionFromJson(json);

  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}
