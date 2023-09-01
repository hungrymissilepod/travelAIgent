import 'package:flutter/gestures.dart';
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
              const SizedBox(height: bigSpacer),
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: smallSpacer),
              SuperRichText(
                text: '${viewModel.plan?.description}',
                maxLines: viewModel.descriptionIsExpanded ? null : 4,
                overflow: viewModel.descriptionIsExpanded ? TextOverflow.clip : TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: viewModel.onReadMoreTap,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(top: 20)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      viewModel.descriptionIsExpanded ? 'Show less' : 'Read more',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade400,
                      ),
                    ),
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Divider(
                          height: 20,
                          thickness: 0.4,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(),
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
                        color: Colors.blue.shade400,
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
