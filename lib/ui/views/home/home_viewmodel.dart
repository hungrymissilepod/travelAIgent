import 'package:dart_countries/dart_countries.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.bottomsheets.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('HomeViewModel');

  // final WebScraperService _webScraperService = locator<WebScraperService>();
  // final AiService _aiService = locator<AiService>();

  HomeViewModel() {
    /// Generate this list of country names once on init
    _generateCountriesList();
  }

  List<String> _countriesList = <String>[];
  List<String> get countriesList => _countriesList;

  bool? _anywhereCheckBoxChecked = false;
  bool? get anywhereCheckBoxChecked => _anywhereCheckBoxChecked;

  void toggleAnywhereCheckBox(bool? b) {
    _anywhereCheckBoxChecked = b;
    rebuildUi();
  }

  double _travelDistance = 12;
  double get travelDistance => _travelDistance;

  void updateTravelDistance(double value) {
    _travelDistance = value.clamp(1, 24).round().toDouble();
    rebuildUi();
  }

  String travelDistanceLabel() {
    if (_travelDistance == 1) {
      return 'I am willing to travel for up to ${_travelDistance.toInt()} hour';
    }
    return 'I am willing to travel for up to ${_travelDistance.toInt()} hours';
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

  void _generateCountriesList() {
    /// Sort all countries in alphabetic order
    final List<Country> countriesCopy = List<Country>.from(countries);
    countriesCopy.sort((a, b) => a.name.compareTo(b.name));

    /// Return list of country names with flags
    _countriesList = countriesCopy.map((e) => '${e.name}').toList();
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

  String from = '';
  String to = '';

  void onGenerateTapped() {
    _logger.i(
        'from: $from - to: $to - anywhereCheckBoxChecked: $_anywhereCheckBoxChecked - travelDistance: $_travelDistance');

    /// TODO: add validation and check it here before navigating
    _navigationService.navigateToPreferencesView();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked 5 stars on Github',
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
