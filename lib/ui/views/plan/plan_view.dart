import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/models/attraction_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

import 'plan_viewmodel.dart';

class PlanView extends StackedView<PlanViewModel> {
  const PlanView({Key? key, this.savedPlan}) : super(key: key);

  final Plan? savedPlan;

  @override
  Widget builder(
    BuildContext context,
    PlanViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: Offstage(
          offstage: viewModel.isBusy,
          child: GestureDetector(
            onTap: savedPlan == null ? viewModel.onExitButtonTap : viewModel.onContinueButtonTap,
            child: Icon(
              savedPlan == null ? Icons.close : Icons.arrow_back_rounded,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: viewModel.isBusy ? const PlanViewLoadingState() : const PlanViewLoadedState(),
      ),
      bottomNavigationBar: Visibility(
        visible: !viewModel.isBusy && savedPlan == null,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CTAButton(
                  onTap: viewModel.onTryAgainButtonTap,
                  label: 'Get another suggestion',
                  style: CTAButtonStyle.outline,
                ),
                const SizedBox(
                  height: 15,
                ),
                CTAButton(
                  onTap: viewModel.onSaveTripTap,
                  label: 'Save Trip',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PlanViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewModel();

  @override
  void onViewModelReady(PlanViewModel viewModel) => viewModel.generatePlan(savedPlan);
}

class PlanViewLoadingState extends StatelessWidget {
  const PlanViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class PlanViewLoadedState extends ViewModelWidget<PlanViewModel> {
  const PlanViewLoadedState({super.key});

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jake, you'll love ${viewModel.plan?.city ?? ''}",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Image.network(viewModel.plan?.imageUrl ?? '',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover, errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    /// TODO: show image load error here
                    return Container(
                      height: 250,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'failed to load image for: ${viewModel.plan?.imageUrl}',
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'At a glace',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PlanViewDetailRow(
                        icon: FontAwesomeIcons.locationDot,
                        label: '${viewModel.plan?.city}, ${viewModel.plan?.country}',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PlanViewDetailRow(
                        icon: FontAwesomeIcons.calendarDays,
                        label:
                            '${viewModel.destination.fromDate.datePickerFormat()} - ${viewModel.destination.toDate.datePickerFormat()}',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PlanViewDetailRow(
                        icon: FontAwesomeIcons.plane,
                        label: '${viewModel.plan?.distance} ${viewModel.getDistanceString()}',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PlanViewDetailRow(
                        icon: FontAwesomeIcons.personWalkingLuggage,
                        label: '${viewModel.destination.travellers} ${viewModel.getTravellerString()}',
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      /// TODO: should we use a weather api to get more accurate weather data?
                      /// Could show different icons based on weather data? Snowflake, clouds, rain, lightning, etc.
                      PlanViewDetailRow(
                        icon: Icons.sunny,
                        label: '${viewModel.plan?.temperature}${viewModel.getTemperatureString()}',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PlanViewDetailRow(
                        icon: FontAwesomeIcons.language,
                        label: '${viewModel.plan?.language}',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Text(
                '${viewModel.plan?.description}',
              ),
              const SizedBox(
                height: 30,
              ),

              /// TODO: could possibly show useful information like the price of things in this place? Price of a meal, beer, hotel room? Average prices of things.

              /// TODO: could show some fun facts about the place?
              const Text(
                'Things to do',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(
                height: 16,
              ),
              SeparatedColumn(
                children: viewModel.plan?.attractions == null
                    ? <Widget>[]
                    : viewModel.plan!.attractions
                        .map((e) => AttractionView(
                              attraction: e,
                            ))
                        .toList(),
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Divider(
                      height: 32,
                      thickness: 1,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttractionView extends StatelessWidget {
  const AttractionView({super.key, required this.attraction});

  final Attraction attraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Image.network(attraction.imageUrl ?? '', height: 300, fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              /// TODO: show image load error here
              return Container(
                height: 300,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'failed to load image for: ${attraction.name}',
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        attraction.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: 16,
                          color: Color(0xfff4be45),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${attraction.rating}',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(attraction.type),
                const SizedBox(
                  height: 10,
                ),
                Text(attraction.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanViewDetailRow extends StatelessWidget {
  const PlanViewDetailRow({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FaIcon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 16,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
