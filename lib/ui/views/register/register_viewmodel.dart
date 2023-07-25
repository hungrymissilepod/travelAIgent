import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/password_validators.dart';
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
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hasPasswordCharacterMinimumError = true;
  bool hasPasswordUpperCaseCharacterError = true;
  bool hasPasswordLowerCaseCharacterError = true;
  bool hasPasswordOneNumberError = true;
  bool hasPasswordOneSpecialCharacter = true;

  bool obscurePasswordText = true;
  bool hasUserAgreedTerms = false;

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
    String value = passwordController.text;
    if (value.isEmpty) {
      setErrorForObject(RegisterViewTextField.password, true);
    } else {
      setErrorForObject(RegisterViewTextField.password, null);
    }

    if (value.length >= 8) {
      setErrorForObject(RegisterViewPasswordTextFieldError.characterMinimum, null);
    } else {
      setErrorForObject(RegisterViewPasswordTextFieldError.characterMinimum, true);
    }

    if (value.containsUppercase) {
      setErrorForObject(RegisterViewPasswordTextFieldError.upperCaseCharacter, null);
    } else {
      setErrorForObject(RegisterViewPasswordTextFieldError.upperCaseCharacter, true);
    }

    if (value.containsLowercase) {
      setErrorForObject(RegisterViewPasswordTextFieldError.lowerCaseCharacter, null);
    } else {
      setErrorForObject(RegisterViewPasswordTextFieldError.lowerCaseCharacter, true);
    }

    if (value.containsNumber) {
      setErrorForObject(RegisterViewPasswordTextFieldError.oneNumber, null);
    } else {
      setErrorForObject(RegisterViewPasswordTextFieldError.oneNumber, true);
    }

    if (value.containsSpecialCharacter) {
      setErrorForObject(RegisterViewPasswordTextFieldError.oneSpecialCharacter, null);
    } else {
      setErrorForObject(RegisterViewPasswordTextFieldError.oneSpecialCharacter, true);
    }

    hasPasswordCharacterMinimumError = _hasPasswordValidationError(RegisterViewPasswordTextFieldError.characterMinimum);
    hasPasswordUpperCaseCharacterError =
        _hasPasswordValidationError(RegisterViewPasswordTextFieldError.upperCaseCharacter);
    hasPasswordLowerCaseCharacterError =
        _hasPasswordValidationError(RegisterViewPasswordTextFieldError.lowerCaseCharacter);
    hasPasswordOneNumberError = _hasPasswordValidationError(RegisterViewPasswordTextFieldError.oneNumber);
    hasPasswordOneSpecialCharacter =
        _hasPasswordValidationError(RegisterViewPasswordTextFieldError.oneSpecialCharacter);

    /// At this point all password validation has passed
    if (!hasAnyPasswordError()) {
      setErrorForObject(RegisterViewTextField.password, null);
    }

    rebuildUi();
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
    /// Ensure all fields have values
    if (fullNameController.text.isEmpty && emailController.text.isEmpty && passwordController.text.isEmpty) {
      return;
    }

    /// Run all fields validation again
    validateFullName();
    validateEmail();
    validatePassword();

    /// Ensure we don't have any errors still
    if (hasAnyFullNameError()) return;
    if (hasAnyEmailError()) return;
    if (hasAnyPasswordError()) return;

    /// Ensure user has agreed to terms
    if (!hasUserAgreedTerms) return;

    /// TODO: try to register user with Firebase
  }

  bool _hasPasswordValidationError(RegisterViewPasswordTextFieldError type) {
    if (error(type) != null) {
      return true;
    }
    return false;
  }

  /// TODO: should this be green or black?
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
