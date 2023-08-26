import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/home/ui/date_picker.dart';
import 'package:travel_aigent/ui/views/home/ui/destination_textfield.dart';
import 'package:travel_aigent/ui/views/home/ui/flexible_destinations/flexible_destination_expansion_tile.dart';
import 'package:travel_aigent/ui/views/home/ui/travellers_picker.dart';
import 'package:travel_aigent/ui/views/home/ui/welcome_card.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';
import 'dart:math';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  void onDatePickerTap(BuildContext context, HomeViewModel viewModel) async {
    final List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: context,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      value: [viewModel.fromDate, viewModel.toDate],
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: DateTime.now(),
        currentDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)),
        firstDayOfWeek: 1,
        calendarType: CalendarDatePicker2Type.range,
        selectedDayTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        selectedDayHighlightColor: Colours.accent,
        centerAlignModePicker: true,
      ),
    );
    if (results != null) {
      viewModel.updateDates(results[0], results[1]);
    }
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  /// TODO: add a Form widget above everything here and add validation to all fields
  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Image.asset(
                'assets/travel3.png',
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const WelcomeCard(),
                  DestinationTextfield(
                    suggestions: viewModel.airportData,
                    focusNode: viewModel.whereFromFocusNode,
                    controller: viewModel.whereFromController,
                    icon: FontAwesomeIcons.planeDeparture,
                    unfocusedHintText: 'From?',
                    hasError: viewModel.fromTextFieldHasError(),
                    onChanged: (String s) => viewModel.rebuildUi(),
                  ),
                  DestinationTextfield(
                    suggestions: viewModel.airportData,
                    focusNode: viewModel.whereToFocusNode,
                    controller: viewModel.whereToController,
                    icon: FontAwesomeIcons.planeArrival,
                    unfocusedHintText: 'To?',
                    hasError: viewModel.fromToFieldHasError(),
                    onChanged: (String s) => viewModel.rebuildUi(),
                    showAnywhereAsDefaultSuggestion: true,
                  ),
                  const FlexibleDestinationExpansionTile(),
                  const SizedBox(height: 10),
                  DatePicker(
                    onTap: () => onDatePickerTap(context, viewModel),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: scaffoldHorizontalPadding),
                    child: TravellersPicker(),
                  ),
                  const SizedBox(height: smallSpacer),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: scaffoldHorizontalPadding),
                    child: CTAButton(
                      onTap: viewModel.onGenerateTapped,
                      label: 'Generate Trip',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
