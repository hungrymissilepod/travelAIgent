import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/attraction_model.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/models/preferences_model.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';

/*

Sample responses:
{"city":"Cape Town","attractions":[{"name":"Table Mountain","description":"majestic flat-topped mountain offering stunning views"},{"name":"Robben Island","description":"historic island where Nelson Mandela was imprisoned"},{"name":"Victoria & Alfred Waterfront","description":"vibrant waterfront with shops, restaurants, and entertainment"}]}

{"city":"Tokyo","attractions":[{"name":"Tokyo Tower","description":"Iconic communication tower with city views"},{"name":"Senso-ji Temple","description":"Oldest Buddhist temple in Tokyo"},{"name":"Shibuya Crossing","description":"Busiest pedestrian crossing in the world"}]}

{"city":"Rio de Janeiro","attractions":[{"name":"Christ the Redeemer","description":"Iconic statue overlooking the city"},{"name":"Copacabana Beach","description":"Vibrant beach known for its New Year's Eve celebrations"},{"name":"Sugarloaf Mountain","description":"Stunning granite peak offering panoramic views"}]}

{"city":"Berlin","attractions":[{"name":"Brandenburg Gate","description":"Iconic neoclassical monument and symbol of German reunification."},{"name":"Museum Island","description":"UNESCO World Heritage Site housing several renowned museums."},{"name":"Berlin Wall","description":"Historical landmark that divided the city for almost 30 years."}]}

{"city":"Krakow","attractions":[{"name":"Wawel Castle","description":"Medieval royal castle and cathedral"},{"name":"Main Market Square","description":"Historic square lined with colorful townhouses and the Cloth Hall"},{"name":"Auschwitz-Birkenau Memorial and Museum","description":"Infamous former Nazi concentration and extermination camp"}]}

{"city":"Krakow","attractions":[{"name":"Old Town","description":"Historical district with beautiful architecture and a lively atmosphere."},{"name":"Wawel Castle","description":"Impressive medieval royal residence with stunning views of the city."},{"name":"Auschwitz-Birkenau","description":"Infamous concentration camp-turned-memorial, serving as a stark reminder of the Holocaust."}]}

{"city":"Paris", "description":"Paris, the capital of France, is known for its iconic landmarks, art, fashion, and cuisine. The City of Light attracts millions of visitors each year, who come to admire its stunning architecture, wander through its charming neighborhoods, and indulge in its world-class shopping and dining scene. With a rich history dating back to Roman times, Paris offers a perfect blend of tradition and modernity, making it one of the most romantic and culturally vibrant cities in the world. ","attractions":[{"name":"Eiffel Tower","description":"Iconic iron lattice tower offering breathtaking views of Paris."},{"name":"Louvre Museum","description":"World's largest art museum housing famous masterpieces like the Mona Lisa."},{"name":"Notre-Dame Cathedral","description":"Gothic masterpiece known for its stunning architecture and stained glass windows."}]}

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

  DestinationModel get destination => _destination;
  PreferencesModel get preferences => _preferences;

  void setDestination(DestinationModel destination) {
    _destination = destination;
    _logger.i('setDestination: ${_destination.toString()}');
  }

  void setPreferences(PreferencesModel preferences) {
    _preferences = preferences;
    _logger.i('setPreferences: ${_preferences.toString()}');
  }

  Future<Plan> generatePlan2() async {
    final String place = 'Europe';
    final String month = 'June'; // TODO: get average month from users preference date
    final String temperatureSystem = 'celcius'; // TODO: could add option for farenheit later

    /// TODO: GPT doens't seem very good at getting [distanceHours] correct. Maybe change this to display timezone instead?

    final String prompt =
        'Give me a famous city in $place, a 5 sentence paragraph about the city, the top 3 attractions with a 2-3 sentence description of each, and what kind of attraction it is, and a rating out of 5, the average temperature for $month in $temperatureSystem degrees, the distance in hours by airplane from ${destination.from} as an int, the native language of the country, as if you are a travel agent. Respond in this JSON format:{"city":"city", "country":"country", "description":"description", "temperature": "temperature", "distance":distance, "language":"language", "attractions":[{"name":"name","description":"description","type":"type", "rating":rating}]}';
    final String response = await _aiService.request(prompt, 500);
    print(response);

    Plan plan = Plan.fromJson(json.decode(response));
    print(plan.toString());

    plan.imageUrl = await _webScraperService.getWikipediaLargeImageUrlFromSearch(plan.city);

    for (Attraction attraction in plan.attractions) {
      String url = await _webScraperService.getWikipediaLargeImageUrlFromSearch(attraction.name);
      attraction.imageUrl = url;
    }
    return plan;
  }
}
