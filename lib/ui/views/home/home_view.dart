import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/home/ui/date_picker.dart';
import 'package:travel_aigent/ui/views/home/ui/destination_textfield.dart';
import 'package:travel_aigent/ui/views/home/ui/travellers_picker.dart';
import 'package:travel_aigent/ui/views/home/ui/welcome_card.dart';

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
        selectedDayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/svgs/airport_blob.png',
            ),
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const WelcomeCard(),
                  DestinationTextfield(
                    // suggestions: viewModel.countriesList,
                    suggestions: viewModel.suggestions,
                    focusNode: viewModel.whereFromFocusNode,
                    controller: viewModel.whereFromController,
                    hintText: 'From?',
                    icon: FontAwesomeIcons.planeDeparture,
                  ),
                  DestinationTextfield(
                    // suggestions: viewModel.whereToCountriesList,
                    suggestions: viewModel.suggestions,
                    focusNode: viewModel.whereToFocusNode,
                    controller: viewModel.whereToController,
                    hintText: 'To?',
                    icon: FontAwesomeIcons.planeArrival,
                  ),
                  DatePicker(
                    onTap: () => onDatePickerTap(context, viewModel),
                  ),
                  const TravellersPicker(),
                  const SizedBox(
                    height: 50,
                  ),
                  CTAButton(
                    onTap: viewModel.onGenerateTapped,
                    label: 'Generate Trip',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
