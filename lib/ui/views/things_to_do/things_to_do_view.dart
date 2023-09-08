import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/views/plan/ui/attraction_view.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

import 'things_to_do_viewmodel.dart';

class ThingsToDoView extends StackedView<ThingsToDoViewModel> {
  const ThingsToDoView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final Plan? plan;

  @override
  Widget builder(
    BuildContext context,
    ThingsToDoViewModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Things to do',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: smallSpacer),
        SeparatedColumn(
          children: plan?.attractions == null
              ? <Widget>[]
              : plan!.attractions
                  .map((e) => AttractionView(attraction: e))
                  .toList(),
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
    );
  }

  @override
  ThingsToDoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ThingsToDoViewModel();
}
