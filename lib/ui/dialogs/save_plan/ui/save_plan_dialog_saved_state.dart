import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/save_plan_dialog_model.dart';

class SavePlanSavedState extends ViewModelWidget<SavePlanDialogModel> {
  const SavePlanSavedState({super.key});

  @override
  Widget build(BuildContext context, SavePlanDialogModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Lottie.asset(
          'assets/bookmark.json',
          repeat: false,
          height: 100,
          width: 100,
        ),
        Column(
          children: <Widget>[
            const Text(
              'Your Trip has been saved!\n\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'View your saved Trips in the\nSaved Trips page.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: CTAButton(
                onTap: viewModel.onDoneTap,
                label: 'Done',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
