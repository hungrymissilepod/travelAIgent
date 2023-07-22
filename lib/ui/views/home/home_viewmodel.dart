import 'package:dart_countries/dart_countries.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.bottomsheets.dart';
import 'package:travel_aigent/app/app.dialogs.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/services/generator_service.dart';
import 'package:travel_aigent/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final GeneratorService _generatorService = locator<GeneratorService>();
  final Logger _logger = getLogger('HomeViewModel');

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
    _generatorService.setDestination(DestinationModel(from, to, _anywhereCheckBoxChecked ?? false, _travelDistance));
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
