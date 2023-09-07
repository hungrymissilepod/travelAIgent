import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:super_rich_text/super_rich_text.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

import 'description_section_viewmodel.dart';

class DescriptionSectionView extends StackedView<DescriptionSectionViewModel> {
  const DescriptionSectionView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final Plan? plan;

  @override
  Widget builder(
    BuildContext context,
    DescriptionSectionViewModel viewModel,
    Widget? child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          text: '${plan?.description}',
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
                  fontWeight: FontWeight.bold,
                  color: Colours.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  DescriptionSectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DescriptionSectionViewModel();
}
