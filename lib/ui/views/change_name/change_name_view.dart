import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_error_view.dart';
import 'package:travel_aigent/ui/common/common_text_form_field.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field_error_text.dart';

import 'change_name_viewmodel.dart';

class ChangeNameView extends StackedView<ChangeNameViewModel> {
  const ChangeNameView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChangeNameViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Enter a new display name',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonErrorView(
                        visibile: viewModel.showErrorView,
                        message: viewModel.errorViewMessage,
                        onCloseTap: viewModel.onErrorCloseIconTap,
                      ),
                      CommonTextFormField(
                        controller: viewModel.fullNameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.none,
                        hintText: 'Name',
                        prefixIcon: Icons.person,
                        suffixIcon: Icons.check,
                        suffixIconColor: viewModel.getSuffixIconColor(
                            viewModel.fullNameController,
                            viewModel.hasErrorForKey(
                                RegisterViewTextField.fullName)),
                        onChanged: (String? value) =>
                            viewModel.validateFullName(),
                        enabledBorderColor: viewModel.getEnabledBorderColor(
                            viewModel.hasErrorForKey(
                                RegisterViewTextField.fullName)),
                        focusedBorderColor: viewModel.getFocusedBorderColor(
                            viewModel.hasErrorForKey(
                                RegisterViewTextField.fullName)),
                        child: RegisterViewTextFormFieldErrorText(
                          visible: viewModel
                              .hasErrorForKey(RegisterViewTextField.fullName),
                          label: 'Please enter your name',
                        ),
                      ),
                    ],
                  ),
                  CTAButton(
                    onTap: () => viewModel.onSaveTap(),
                    label: 'Save',
                    isLoading: viewModel.isBusy,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChangeNameViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChangeNameViewModel();
}
