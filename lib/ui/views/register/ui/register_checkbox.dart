import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:super_rich_text/super_rich_text.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';

class RegisterCheckbox extends ViewModelWidget<RegisterViewModel> {
  const RegisterCheckbox({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: viewModel.hasUserAgreedTerms,
          onChanged: (bool? b) => viewModel.toggleUserAgreedTerms(b),
        ),
        Flexible(
          child: SuperRichText(
            text: 'By signing up you accept our tcTerms and Conditionstc and ppPrivacy Policypp',
            othersMarkers: [
              MarkerText.withFunction(
                marker: 'tc',
                functions: [
                  () {
                    viewModel.onTermsTapped();
                  }
                ],
                style: const TextStyle(color: Colors.blue),
              ),
              MarkerText.withFunction(
                marker: 'pp',
                functions: [
                  () {
                    viewModel.onPrivacyTapped();
                  }
                ],
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
