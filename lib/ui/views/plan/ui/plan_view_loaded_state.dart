import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/at_a_glace_section/at_a_glace_section_view.dart';
import 'package:travel_aigent/ui/views/average_price_section/average_price_section_view.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/attraction_view.dart';
import 'package:travel_aigent/ui/views/plan/ui/image_carousel.dart';

const double smallSpacer = 16;
const double bigSpacer = 30;

class PlanViewLoadedState extends ViewModelWidget<PlanViewModel> {
  const PlanViewLoadedState({super.key});

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                viewModel.title(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: bigSpacer),
              ImageCarousel(
                images: viewModel.plan?.images ?? [],
                height: 250,
              ),
              const SizedBox(height: smallSpacer),
              AtAGlaceSectionView(
                plan: viewModel.plan,
                destination: viewModel.destination,
              ),
              const SizedBox(height: smallSpacer),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: smallSpacer),
              Text('${viewModel.plan?.description}'),
              const SizedBox(height: smallSpacer),
              AveragePriceSectionView(
                plan: viewModel.plan,
              ),
              const SizedBox(height: smallSpacer),

              /// TODO: could show some fun facts about the place?
              const Text(
                'Things to do',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: smallSpacer),
              SeparatedColumn(
                children: viewModel.plan?.attractions == null
                    ? <Widget>[]
                    : viewModel.plan!.attractions.map((e) => AttractionView(attraction: e)).toList(),
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
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
