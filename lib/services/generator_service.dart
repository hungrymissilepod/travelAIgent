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
{"city":"Rome","country":"Italy","description":"Rome, known as the Eternal City, is the capital of Italy. With its rich history and iconic landmarks, it is a city that truly captures the imagination. Visitors can wander through ancient ruins, admire world-renowned art, and enjoy delicious Italian cuisine.","temperature":"25","distance":2,"language":"Italian","attractions":[{"name":"Colosseum","description":"The Colosseum is a grand amphitheater that once hosted gladiatorial contests. It is a remarkable architectural feat and a symbol of ancient Rome's power.","type":"Historical","rating":5},{"name":"Vatican City","description":"Vatican City is an independent city-state and the spiritual heart of Catholicism. Visitors can explore St. Peter's Basilica, the Vatican Museums, and gaze upon Michelangelo's breathtaking frescoes in the Sistine Chapel.","type":"Religious","rating":4.5},{"name":"Trevi Fountain","description":"The Trevi Fountain is a stunning Baroque masterpiece and one of Rome's most famous landmarks. Visitors can toss a coin into the fountain, following the tradition that ensures a return to Rome.","type":"Sightseeing","rating":4}]}

{"city":"Paris","country":"France","description":"Paris, the capital city of France, is known around the world for its romantic charm, stunning architecture, and vibrant cultural scene. With its iconic landmarks such as the Eiffel Tower and Louvre Museum, Paris offers a perfect blend of history, art, and cuisine. The city's wide boulevards, charming cafes, and world-class shopping make it a truly enchanting destination.","temperature":"20°C","distance":8,"language":"French","attractions":[{"name":"Eiffel Tower","description":"A symbol of Paris and one of the world's most famous landmarks, the Eiffel Tower offers breathtaking views of the city from its observation decks. It is a marvel of engineering and a must-visit attraction in Paris.","type":"Landmark","rating":5},{"name":"Louvre Museum","description":"The Louvre Museum is the world's largest art museum and home to thousands of masterpieces, including the renowned Mona Lisa. With its impressive collection spanning various periods of history, art lovers will be captivated by this cultural gem.","type":"Museum","rating":4.5},{"name":"Notre-Dame Cathedral","description":"A masterpiece of French Gothic architecture, Notre-Dame Cathedral is a stunning cathedral located on the Île de la Cité. Visitors can admire its intricate stained glass windows, towering spires, and explore the iconic bell towers for panoramic views of Paris.","type":"Religious Site","rating":4.8}]}

{"city":"Vienna","country":"Austria","description":"Vienna, the capital city of Austria, is known for its rich culture, artistic heritage, and stunning architecture. It is often referred to as the 'City of Music' due to its historical association with renowned composers such as Mozart, Beethoven, and Strauss. Visitors can explore the city's many museums, palaces, and concert halls, or simply wander through its charming streets and enjoy the vibrant atmosphere. Vienna also boasts a thriving coffeehouse culture, where one can relax and indulge in delicious pastries, while enjoying the Viennese way of life.","temperature":"20°C","distance":2,"language":"German","attractions":[{"name":"Schönbrunn Palace","description":"As one of the most important cultural landmarks in Austria, Schönbrunn Palace offers a glimpse into the imperial history of Vienna. Visitors can explore the majestic palace interiors, stroll through the sprawling gardens, and even watch a classical concert in the Orangery. (Type: Cultural, Rating: 5/5)"},{"name":"St. Stephen's Cathedral","description":"Located in the heart of the city, St. Stephen's Cathedral is a stunning example of Gothic architecture. Visitors can climb the tower for panoramic views of Vienna, admire the intricate details of the interior, or attend a choir performance or organ concert. (Type: Historical, Rating: 4/5)"},{"name":"Belvedere Palace","description":"Belvedere Palace is a masterpiece of Baroque architecture that houses an impressive collection of Austrian art. Visitors can view the renowned artwork, including Gustav Klimt's famous painting 'The Kiss,' as well as explore the beautiful gardens and fountains. (Type: Art & Culture, Rating: 4/5)"}]}

{"city": "Copenhagen", "country": "Denmark", "description": "Copenhagen, the capital city of Denmark, is located on the eastern coast of the island of Zealand. Known for its charm, Copenhagen offers a harmonious blend of historical landmarks, modern architecture, and a laid-back atmosphere. Explore the picturesque canals, vibrant neighborhoods, and trendy cafes of this cosmopolitan city.", "temperature": "17", "distance": 2, "language": "Danish", "attractions": [{"name": "Tivoli Gardens", "description": "Tivoli Gardens is a world-famous amusement park offering a mix of thrilling rides, beautiful gardens, live performances, and restaurants. It is a fantastic place to experience the Danish culture and have fun with family and friends.", "type": "Amusement Park", "rating": 5}, {"name": "The Little Mermaid", "description": "The iconic bronze statue inspired by Hans Christian Andersen's fairytale, 'The Little Mermaid,' is a must-see attraction. Situated by the water's edge, it showcases the city's maritime history and offers a perfect spot for a serene stroll.", "type": "Landmark", "rating": 4.5}, {"name": "Nyhavn", "description": "Nyhavn, with its colorful 17th-century townhouses, is a picturesque waterfront district brimming with restaurants, bars, and cafes. Take a leisurely boat tour along the canal or enjoy a delightful meal while enjoying the vibrant atmosphere of this historical harbor area.", "type": "Neighborhood", "rating": 4}] }

*/

// TODO: sometimes wikipedia responds with an iage called Question_book-svg.svg.
// If we return this DO NOT display it. Have to get image from TripAdvistor
// Or we need to make the wikipedia scraper smarter
// Is it possibly to query wikipedia for images rather than navigating the articles?

class GeneratorService {
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final AiService _aiService = locator<AiService>();
  final Logger _logger = getLogger('GeneratorService');

  late Destination _destination;
  late Preferences _preferences;

  Destination get destination => _destination;
  Preferences get preferences => _preferences;

  void setDestination(Destination destination) {
    _destination = destination;
    _logger.i('setDestination: ${_destination.toString()}');
  }

  void setPreferences(Preferences preferences) {
    _preferences = preferences;
    _logger.i('setPreferences: ${_preferences.toString()}');
  }

  Future<Plan> generatePlan2() async {
    final String place = 'Denmark';
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
