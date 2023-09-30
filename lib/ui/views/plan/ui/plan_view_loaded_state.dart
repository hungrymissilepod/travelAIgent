import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/refresh_text.dart';
import 'package:travel_aigent/ui/views/at_a_glace_section/at_a_glace_section_view.dart';
import 'package:travel_aigent/ui/views/average_price_section/average_price_section_view.dart';
import 'package:travel_aigent/ui/views/description_section/description_section_view.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/image_carousel.dart';
import 'package:travel_aigent/ui/views/things_to_do/things_to_do_view.dart';
import 'package:travel_aigent/ui/views/your_preferences/your_preferences_view.dart';

const double smallSpacer = 16;
const double bigSpacer = 30;

class PlanViewLoadedState extends ViewModelWidget<PlanViewModel> {
  const PlanViewLoadedState({
    super.key,
    required this.isSavedPlan,
  });

  final bool isSavedPlan;

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                viewModel.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: smallSpacer),
              ImageCarousel(
                images: viewModel.plan?.images ?? [],
                height: 300,
              ),
              const SizedBox(height: smallSpacer),
              AtAGlaceSectionView(
                plan: viewModel.plan,
                destination: viewModel.destination,
              ),
              const SizedBox(height: bigSpacer * 1.5),
              DescriptionSectionView(plan: viewModel.plan),
              const SizedBox(height: bigSpacer * 1.5),
              AveragePriceSectionView(plan: viewModel.plan),
              const SizedBox(height: bigSpacer * 1.5),
              ThingsToDoView(plan: viewModel.plan),
              const SizedBox(height: bigSpacer),
              YourPreferencesView(plan: viewModel.plan),
              const SizedBox(height: smallSpacer),
              const SizedBox(height: bigSpacer),
              Visibility(
                visible: isSavedPlan == false,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Not what you are looking for?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      RefreshText(
                        onTap: viewModel.onTryAgainButtonTap,
                        color: Colours.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: bigSpacer),
            ],
          ),
        ),
      ),
    );
  }
}
