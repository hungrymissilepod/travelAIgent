import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 250,
              child: viewModel.isBusy
                  ? const _SavePlanDialogLoadingState()
                  : _SavePlanDialogForm(
                      request: request,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SavePlanDialogModel viewModelBuilder(BuildContext context) => SavePlanDialogModel(request.data);
}

class _SavePlanDialogForm extends ViewModelWidget<SavePlanDialogModel> {
  _SavePlanDialogForm({required this.request});

  final DialogRequest request;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, SavePlanDialogModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Name this trip so you can find it later.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Form(
          key: _formKey,
          child: TextFormField(
            autofocus: true,
            controller: viewModel.nameController,
            cursorColor: Theme.of(context).colorScheme.secondary,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: viewModel.onCancelTap,
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colours.accent),
              ),
            ),
            SizedBox(
              width: 140,
              child: CTAButton(
                onTap: () {
                  final FormState? formState = _formKey.currentState;
                  if (formState != null) {
                    if (formState.validate()) {
                      viewModel.onSaveTap();
                    }
                  }
                },
                label: 'Save',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SavePlanDialogLoadingState extends StatelessWidget {
  const _SavePlanDialogLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
