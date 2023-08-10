import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/destination_model.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_view.dart';

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
    return InfoSectionView(
      title: 'At a glace',
      leftColumn: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.locationDot,
          label: viewModel.locationLabel,
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.calendarDays,
          label: viewModel.dateLabel,
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.plane,
          label: viewModel.distanceLavel,
        ),
      ],
      rightColumn: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.personWalkingLuggage,
          label: viewModel.travellersLabel,
        ),
        PlanViewDetailRow(
          icon: Icons.sunny,
          label: viewModel.weatherLabel,
        ),
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
