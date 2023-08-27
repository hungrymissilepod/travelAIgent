import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:super_rich_text/super_rich_text.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_expansion_tile.dart';
import 'package:travel_aigent/ui/common/refresh_text.dart';
import 'package:travel_aigent/ui/views/at_a_glace_section/at_a_glace_section_view.dart';
import 'package:travel_aigent/ui/views/average_price_section/average_price_section_view.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/attraction_view.dart';
import 'package:travel_aigent/ui/views/plan/ui/image_carousel.dart';

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
      controller: viewModel.scrollController,
      child: SingleChildScrollView(
        controller: viewModel.scrollController,
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
                height: 300,
              ),
              const SizedBox(height: bigSpacer),
              AtAGlaceSectionView(
                plan: viewModel.plan,
                destination: viewModel.destination,
              ),
              const SizedBox(height: smallSpacer),
              CommonExpansionTile(
                title: 'Description',
                children: <Widget>[
                  SuperRichText(
                    text: '${viewModel.plan?.description}',
                  ),
                ],
              ),
              const SizedBox(height: smallSpacer),
              AveragePriceSectionView(
                plan: viewModel.plan,
              ),
              const SizedBox(height: smallSpacer),
              CommonExpansionTile(
                title: 'Things to do',
                children: <Widget>[
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
                ],
              ),
              const SizedBox(height: smallSpacer),
              Visibility(
                visible: isSavedPlan == false,
                child: CommonExpansionTile(
                  title: 'Not what you are looking for?',
                  initiallyExpanded: false,
                  onExpanded: () async {
                    await Future.delayed(const Duration(milliseconds: 250));
                    viewModel.scrollController.animateTo(
                      viewModel.scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  children: <Widget>[
                    RefreshText(
                      onTap: viewModel.onTryAgainButtonTap,
                      color: Colours.accent,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
