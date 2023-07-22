import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/attraction_model.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

import 'plan_viewmodel.dart';

class PlanView extends StackedView<PlanViewModel> {
  const PlanView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PlanViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: viewModel.isBusy ? const PlanViewLoadingState() : const PlanViewLoadedState(),
      ),
    );
  }

  @override
  PlanViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PlanViewModel();

  @override
  void onViewModelReady(PlanViewModel viewModel) => viewModel.generatePlan();
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Jake, you'll love ${viewModel.plan?.city ?? ''}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'This is a description of the place that we reccommend and why we reccommend it. If this text is more that 8 lines you can tap to READ MORE and expand it'),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text('The weather here is nice and sunny'),
                Text('time zone data'),
              ],
            ),

            /// TODO: could possibly show useful information like the price of things in this place? Price of a meal, beer, hotel room? Average prices of things.

            /// TODO: could show some fun facts about the place?

            /// TODO: info about the place and country
            /// TODO: weather for that time frame the user will be there
            const SizedBox(
              height: 20,
            ),
            const Text('Things to do'),
            Column(
              children: viewModel.plan?.attractions == null
                  ? <Widget>[]
                  : viewModel.plan!.attractions
                      .map((e) => AttractionCard(
                            attraction: e,
                          ))
                      .toList(),
            ),
            CTAButton(
              onTap: viewModel.onContinueButtonTap,
              label: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  const AttractionCard({super.key, required this.attraction});

  final Attraction attraction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                attraction.imageUrl ?? '',
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text(
                  'failed to load image for: ${attraction.name}',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(attraction.name),
                  Text(attraction.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
