import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/home/ui/date_picker.dart';
import 'package:travel_aigent/ui/views/home/ui/destination_textfield.dart';
import 'package:travel_aigent/ui/views/home/ui/travellers_picker.dart';

import 'home_viewmodel.dart';

const double cardPadding = 12;
const double homePickerHeight = 50;

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
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          left: -10,
          child: Image.asset(
            'assets/svgs/airport_blob.png',
            height: 300,
          ),
        ),
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// Welcome card
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hi Jake!',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Where to?',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// To and from card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(cardPadding),
                  child: Column(
                    children: <Widget>[
                      /// TODO: this should be list of airports
                      DestinationTextfield(
                        suggestions: viewModel.countriesList,
                        focusNode: viewModel.whereFromFocusNode,
                        controller: viewModel.whereFromController,
                        hintText: 'From?',
                      ),
                      DestinationTextfield(
                        suggestions: viewModel.whereToCountriesList,
                        focusNode: viewModel.whereToFocusNode,
                        controller: viewModel.whereToController,
                        hintText: 'To?',
                      ),
                      DatePicker(
                        onTap: () => onDatePickerTap(context, viewModel),
                      ),
                      const TravellersPicker(),
                    ],
                  ),
                ),
              ),
              CTAButton(
                onTap: viewModel.onGenerateTapped,
                label: 'Generate',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
