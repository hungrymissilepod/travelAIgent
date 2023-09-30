import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';

class ChangeNameViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();

  final TextEditingController fullNameController = TextEditingController();

  ChangeNameViewModel() {
    fullNameController.text = _whoAmIService.whoAmI.name ?? '';
    rebuildUi();
  }

  bool showErrorView = false;
  String errorViewMessage = '';

  void onErrorCloseIconTap() {
    showErrorView = false;
    rebuildUi();
  }

  void validateFullName() {
    if (fullNameController.text.isEmpty) {
      setErrorForObject(RegisterViewTextField.fullName, true);
    } else {
      setErrorForObject(RegisterViewTextField.fullName, null);
    }
  }

  bool hasAnyFullNameError() {
    if (error(RegisterViewTextField.fullName) != null) {
      return true;
    }
    return false;
  }

  Future<void> onSaveTap() async {
    clearErrorMessage();

    validateFullName();

    if (hasAnyFullNameError()) return;

    String newName = fullNameController.text;

    bool saved = await runBusyFuture(
      _firestoreService.updateUserName(_firebaseUserService.userId(), newName),
    );

    if (!saved) {
      showErrorMessage('Failed to change name');
      return;
    }

    _navigationService.back();
  }

  void clearErrorMessage() {
    errorViewMessage = '';
    showErrorView = false;
    rebuildUi();
  }

  void showErrorMessage(String msg) {
    errorViewMessage = msg;
    showErrorView = true;
    rebuildUi();
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
