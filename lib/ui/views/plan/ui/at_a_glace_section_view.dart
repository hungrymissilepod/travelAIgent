import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_view.dart';

class AtAGlaceSectionView extends ViewModelWidget<PlanViewModel> {
  const AtAGlaceSectionView({super.key});

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return InfoSectionView(
      title: 'At a glace',
      leftColumn: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.locationDot,
          label: '${viewModel.plan?.city}, ${viewModel.plan?.country}',
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.calendarDays,
          label:
              '${viewModel.destination?.fromDate.datePickerFormat()} - ${viewModel.destination?.toDate.datePickerFormat()}',
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.plane,
          label: '${viewModel.plan?.distance} ${viewModel.getDistanceString()}',
        ),
      ],
      rightColumn: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.personWalkingLuggage,
          label: '${viewModel.destination?.travellers} ${viewModel.getTravellerString()}',
        ),
        PlanViewDetailRow(
          icon: Icons.sunny,
          label: '${viewModel.plan?.temperature}${viewModel.getTemperatureString()}',
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.language,
          label: '${viewModel.plan?.language}',
        ),
      ],
    );
  }
}
