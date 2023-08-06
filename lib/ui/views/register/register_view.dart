import 'dart:core';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_error_view.dart';
import 'package:travel_aigent/ui/common/common_text_form_field.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/register/ui/register_checkbox.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_password_text_form_field.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field_error_text.dart';

import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({
    Key? key,
    this.navigatedFromRegisterPrompt = false,
  }) : super(key: key);

  /// Was the user navigated to this page from the [PromptRegisterDialog]?
  final bool navigatedFromRegisterPrompt;

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
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
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
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
                              viewModel.fullNameController, viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          onChanged: (String? value) => viewModel.validateFullName(),
                          enabledBorderColor:
                              viewModel.getEnabledBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          focusedBorderColor:
                              viewModel.getFocusedBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          child: RegisterViewTextFormFieldErrorText(
                            visible: viewModel.hasErrorForKey(RegisterViewTextField.fullName),
                            label: 'Please enter your name',
                          ),
                        ),
                        CommonTextFormField(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          hintText: 'Email',
                          prefixIcon: Icons.email,
                          suffixIcon: Icons.check,
                          suffixIconColor: viewModel.getSuffixIconColor(
                              viewModel.emailController, viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          onChanged: (String? value) => viewModel.validateEmail(),
                          enabledBorderColor:
                              viewModel.getEnabledBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          focusedBorderColor:
                              viewModel.getFocusedBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          child: RegisterViewTextFormFieldErrorText(
                            visible: viewModel.hasErrorForKey(RegisterViewTextField.email),
                            label: 'Please enter a valid email',
                          ),
                        ),
                        const RegisterViewPasswordFancyTextFormField(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const RegisterCheckbox(),
                      const SizedBox(
                        height: 20,
                      ),
                      CTAButton(
                        onTap: viewModel.onRegisterTap,
                        label: 'Sign up',
                        enabled: viewModel.hasUserAgreedTerms,
                        isLoading: viewModel.isBusy,
                      ),
                    ],
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
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel(navigatedFromRegisterPrompt);
}
