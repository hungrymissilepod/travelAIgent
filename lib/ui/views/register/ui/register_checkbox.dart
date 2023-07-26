import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';

class RegisterCheckbox extends ViewModelWidget<RegisterViewModel> {
  const RegisterCheckbox({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return CheckboxListTile(
      value: viewModel.hasUserAgreedTerms,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
          'By signing up you accept the Terms of service and Privacy Policy'),
      onChanged: (bool? b) => viewModel.toggleUserAgreedTerms(b),
    );
  }
}
