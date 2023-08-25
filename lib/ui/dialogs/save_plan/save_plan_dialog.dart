import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/ui/save_plan_dialog_form.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/ui/save_plan_dialog_loading_state.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/ui/save_plan_dialog_saved_state.dart';

import 'save_plan_dialog_model.dart';

class SavePlanDialog extends StackedView<SavePlanDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SavePlanDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SavePlanDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Save Trip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            viewModel.isBusy
                ? const SavePlanDialogLoadingState()
                : viewModel.planSaved
                    ? const SavePlanSavedState()
                    : SavePlanDialogForm(request: request),
          ],
        ),
      ),
    );
  }

  @override
  SavePlanDialogModel viewModelBuilder(BuildContext context) => SavePlanDialogModel(request.data);
}
