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
import 'package:travel_aigent/ui/views/preferences/ui/holiday_type_view.dart';
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
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Image.asset(
                'assets/travel3.png',
                height: 250,
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
                  ),
                  DestinationTextfield(
                    suggestions: viewModel.airportData,
                    focusNode: viewModel.whereToFocusNode,
                    controller: viewModel.whereToController,
                    icon: FontAwesomeIcons.planeArrival,
                    unfocusedHintText: 'To?',
                  ),
                  DatePicker(
                    onTap: () => onDatePickerTap(context, viewModel),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
                        child: Text(
                          'I\'m flexible',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 70,
                        child: ListView.separated(
                          itemCount: flexibleDestinations.length,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              /// Add [scaffoldHorizontalPadding] to only the first and last cells
                              padding: EdgeInsets.only(
                                left: index == 0 ? scaffoldHorizontalPadding : 0,
                                right: index == flexibleDestinations.length - 1 ? scaffoldHorizontalPadding : 0,
                              ),
                              child: FlexibleDestinationCell(
                                label: flexibleDestinations[index].label,
                                icon: flexibleDestinations[index].icon,
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 10);
                          },
                        ),
                      ),
                    ],
                  ),

                  /// TODO: decide if we want to hide this or not? It currently has no effect on the results the user gets
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
                    child: TravellersPicker(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
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

class FlexibleDestination {
  final String label;
  final IconData icon;

  FlexibleDestination(this.label, this.icon);
}

final List<FlexibleDestination> flexibleDestinations = <FlexibleDestination>[
  FlexibleDestination('Anywhere', FontAwesomeIcons.earthAmericas),
  FlexibleDestination('Europe', FontAwesomeIcons.locationDot),
  FlexibleDestination('North America', FontAwesomeIcons.locationDot),
  FlexibleDestination('South America', FontAwesomeIcons.locationDot),
  FlexibleDestination('Africa', FontAwesomeIcons.locationDot),
  FlexibleDestination('Asia', FontAwesomeIcons.locationDot),
  FlexibleDestination('Australia', FontAwesomeIcons.locationDot),
];

class FlexibleDestinationCell extends ViewModelWidget<HomeViewModel> {
  const FlexibleDestinationCell({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        viewModel.setToTextField(label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: viewModel.whereToController.text == label ? Colours.accent.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: textFieldBorderWidth,
            color: viewModel.whereToController.text == label ? Colours.accent : Colors.black26,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 2,
            ),
            FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
            const SizedBox(width: 13),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
