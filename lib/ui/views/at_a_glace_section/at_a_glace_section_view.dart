import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/common_expansion_tile.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

import 'at_a_glace_section_viewmodel.dart';

class AtAGlaceSectionView extends StackedView<AtAGlaceSectionViewModel> {
  const AtAGlaceSectionView({
    Key? key,
    required this.plan,
    required this.destination,
  }) : super(key: key);

  final Plan? plan;
  final Destination? destination;

  @override
  Widget builder(
    BuildContext context,
    AtAGlaceSectionViewModel viewModel,
    Widget? child,
  ) {
    return CommonExpansionTile(
      title: 'At a glace',
      children: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.locationDot,
          label: viewModel.locationLabel,
        ),
        const SizedBox(height: smallSpacer),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.calendarDays,
          label: viewModel.dateLabel,
        ),
        const SizedBox(height: smallSpacer),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.plane,
          label: viewModel.distanceLavel,
        ),
        const SizedBox(height: smallSpacer),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.personWalkingLuggage,
          label: viewModel.travellersLabel,
        ),
        const SizedBox(height: smallSpacer),
        PlanViewDetailRow(
          icon: Icons.sunny,
          label: viewModel.weatherLabel(),
        ),
        const SizedBox(height: smallSpacer),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.language,
          label: viewModel.languageLabel,
        ),
      ],
    );
  }

  @override
  AtAGlaceSectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AtAGlaceSectionViewModel(plan, destination);
}
