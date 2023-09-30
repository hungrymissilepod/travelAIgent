import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/google_candidates_model.dart';
import 'package:travel_aigent/models/google_place_model.dart';
import 'package:travel_aigent/services/dio_service.dart';

const String googlePlacesApiFindPlaceUrl = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';
const String googlePlacesApiPlaceDetailsUrl = 'https://maps.googleapis.com/maps/api/place/details/json';

class PlacesService {
  final Logger _logger = getLogger('PlacesService');
  final DioService _dioService = locator<DioService>();

  String _placesApiKey = '';

  PlacesService() {
    _placesApiKey = dotenv.env['GCP_PLACES_API_KEY'] ?? '';
  }

  Future<GooglePlace?> fetchPlaceData(String query) async {
    final String placeId = await _fetchPlaceId(query);

    /// If Google fails to find this place, return null
    if (placeId.isEmpty) {
      return null;
    }

    GooglePlace place = await _fetchPlaceDetails(placeId);
    return place;
  }

  Future<String> _fetchPlaceId(String query) async {
    final Response response = await _dioService.get(
      googlePlacesApiFindPlaceUrl,
      parameters: <String, dynamic>{
        'input': query,
        'inputtype': 'textquery',
        'fields': 'place_id',
        'key': _placesApiKey,
      },
    );

    GoogleCandidates candidates = GoogleCandidates.fromJson(response.data);

    if (candidates.candidates.isEmpty) {
      _logger.e('failed to find candidates for search: $query');
      return '';
    }

    return candidates.candidates.first.placeId;
  }

  Future<GooglePlace> _fetchPlaceDetails(String placeId) async {
    final Response response = await _dioService.get(
      googlePlacesApiPlaceDetailsUrl,
      parameters: <String, dynamic>{
        'place_id': placeId,
        'fields': 'place_id,name,formatted_address,rating',
        'key': _placesApiKey,
      },
    );

    GooglePlace place = GooglePlace.fromJson(response.data['result']);
    place.placeId = placeId;
    return place;
  }
}
