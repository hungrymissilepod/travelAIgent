import 'package:dart_countries/dart_countries.dart';
import 'package:travel_aigent/app/app.bottomsheets.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/services/ai_service.dart';
import 'package:travel_aigent/services/web_scraper_service.dart';
import 'package:travel_aigent/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final WebScraperService _webScraperService = locator<WebScraperService>();
  final AiService _aiService = locator<AiService>();

  HomeViewModel(int startingIndex) {
    _counter = startingIndex;

    /// Generate this list of country names once on init
    init();
    _generateCountriesList();
  }

  void init() async {
    setBusy(true);
    final String city = 'London';
    final String places = await _aiService.request(
        'Give me a list of 3 famous attractions in ${city}. Respond as a plain csv without numbering.', 30);
    print('places: $places');

    final List<String> placeList = places.split(',');
    for (String place in placeList) {
      print(place);
      String url = await _webScraperService.getWikipediaLargeImageUrlFromSearch(place);
      imageUrls.add(url);
    }

    // imageUrl = await _webScraperService.getWikipediaLargeImageUrlFromSearch('forbidden city');
    setBusy(false);
  }

  String imageUrl = '';

  List<String> imageUrls = <String>[];

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  List<String> get countriesList => _countriesList;
  List<String> _countriesList = <String>[];

  void _generateCountriesList() {
    /// Sort all countries in alphabetic order
    final List<Country> countriesCopy = List<Country>.from(countries);
    countriesCopy.sort((a, b) => a.name.compareTo(b.name));

    /// Return list of country names with flags
    _countriesList = countriesCopy.map((e) => '${e.flag} ${e.name}').toList();
  }

  double travelDistanceValue = 12;

  String travelDistanceLabel() {
    if (travelDistanceValue == 1) {
      return 'I am willing to travel for up to ${travelDistanceValue.toInt()} hour';
    }
    return 'I am willing to travel for up to ${travelDistanceValue.toInt()} hours';
  }

  void updateTravelDistanceValue(double value) {
    travelDistanceValue = value.clamp(1, 24).round().toDouble();
    rebuildUi();
  }

  List<String> interests = <String>[];

  void updateInterests(String value) {
    interests = value.split(',');
    rebuildUi();
  }

  List<String> holidayTypes = <String>[];

  void updateHolidayTypes(String value) {
    holidayTypes = value.split(',');
    rebuildUi();
  }

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
