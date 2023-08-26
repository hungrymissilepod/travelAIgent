import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/dialogs/save_plan/save_plan_dialog_model.dart';

class SavePlanDialogForm extends ViewModelWidget<SavePlanDialogModel> {
  SavePlanDialogForm({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, SavePlanDialogModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
