import 'package:email_validator/email_validator.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/authentication_service.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

enum RegisterViewTextField { fullName, email, password }

enum RegisterViewPasswordTextFieldError {
  characterMinimum,
  upperCaseCharacter,
  lowerCaseCharacter,
  oneNumber,
  oneSpecialCharacter
}

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(bool navigatedFromRegisterPrompt) {
    _navigatedFromRegisterPrompt = navigatedFromRegisterPrompt;
  }

  bool _navigatedFromRegisterPrompt = false;

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FancyPasswordController fancyPasswordController = FancyPasswordController();

  bool hasPasswordCharacterMinimumError = true;
  bool hasPasswordUpperCaseCharacterError = true;
  bool hasPasswordLowerCaseCharacterError = true;
  bool hasPasswordOneNumberError = true;
  bool hasPasswordOneSpecialCharacter = true;

  bool obscurePasswordText = true;
  bool hasUserAgreedTerms = false;

  bool showErrorView = false;
  String errorViewMessage = '';

  void validateFullName() {
    if (fullNameController.text.isEmpty) {
      setErrorForObject(RegisterViewTextField.fullName, true);
    } else {
      setErrorForObject(RegisterViewTextField.fullName, null);
    }
  }

  void validateEmail() {
    if (EmailValidator.validate(emailController.text) == false) {
      setErrorForObject(RegisterViewTextField.email, true);
    } else {
      setErrorForObject(RegisterViewTextField.email, null);
    }
  }

  void validatePassword() {
    if (passwordController.text.isEmpty) {
      setErrorForObject(RegisterViewTextField.password, true);
    } else {
      setErrorForObject(RegisterViewTextField.password, null);
    }
  }

  bool hasAnyFullNameError() {
    if (error(RegisterViewTextField.fullName) != null) {
      return true;
    }
    return false;
  }

  bool hasAnyEmailError() {
    if (error(RegisterViewTextField.email) != null) {
      return true;
    }
    return false;
  }

  bool hasAnyPasswordError() {
    /// First check if password textfield has error
    if (error(RegisterViewTextField.password) != null) {
      return true;
    }

    /// Then check to see if any password validators have errors
    for (RegisterViewPasswordTextFieldError e in RegisterViewPasswordTextFieldError.values) {
      if (_hasPasswordValidationError(e)) {
        return true;
      }
    }
    return false;
  }

  void toggleObscurePasswordText() {
    obscurePasswordText = !obscurePasswordText;
    rebuildUi();
  }

  void toggleUserAgreedTerms(bool? b) {
    hasUserAgreedTerms = b ?? false;
    rebuildUi();
  }

  void onRegisterTap() {
    /// Run all fields validation
    validateFullName();
    validateEmail();
    validatePassword();

    /// Ensure we don't have any errors still
    if (hasAnyFullNameError()) return;
    if (hasAnyEmailError()) return;

    /// Ensure user has agreed to terms
    if (!hasUserAgreedTerms) return;

    _registerWithEmailAndPassword();
  }

  Future<void> _registerWithEmailAndPassword() async {
    final String? response = await runBusyFuture(
      _authenticationService.linkUserWithEmailCredential(
        fullNameController.text,
        emailController.text,
        passwordController.text,
      ),
    );

    /// Check if we got an error message when creating account and show it here
    if (response != null) {
      errorViewMessage = _getErrorViewMessage(response);
      showErrorView = true;
      rebuildUi();
      return;
    }

    /// If user navigated to this page from the [PromptRegisterDialog], we take them back to [PlanView]
    if (_navigatedFromRegisterPrompt) {
      _navigationService.back(result: true);
      return;
    }
    return _navigationService.clearStackAndShow(Routes.dashboardView);
  }

  void onErrorCloseIconTap() {
    showErrorView = false;
    rebuildUi();
  }

  String _getErrorViewMessage(String? response) {
    switch (response) {
      case 'failed-get-email-credential':
        return 'Failed to create an account with this email';
      case 'provider-already-linked':
        return 'The provider has already been linked to the user';
      case 'invalid-credential':
        return 'The provider\'s credential is not valid';
      case 'credential-already-in-use':
        return 'The account corresponding to the credential already exists, or is already linked to user';
      case 'no-user-credential':
        return 'No user credential';
      case 'failed-to-save-user-data':
        return 'Failed to save user data';
      case 'email-already-in-use':
        return 'A account with this email address already exists';
      case 'invalid-email':
        return 'Invalid email address';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'weak-password':
        return 'This password is too weak. Please try again with another password';
      default:
        return 'An error occured, please try again.';
    }
  }

  bool _hasPasswordValidationError(RegisterViewPasswordTextFieldError type) {
    if (error(type) != null) {
      return true;
    }
    return false;
  }

  Color? getSuffixIconColor(TextEditingController controller, bool hasError) {
    if (controller.text.isNotEmpty && hasError == false) {
      return Colors.green;
    }
    return Colors.grey;
  }

  Color getEnabledBorderColor(bool b) {
    return b ? Colors.red : Colors.grey;
  }

  Color getFocusedBorderColor(bool b) {
    return b ? Colors.red : Colours.accent;
  }
}
