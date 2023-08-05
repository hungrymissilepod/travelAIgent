import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/app/app.router.dart';

class PromptRegisterDialogModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _logger = getLogger('PromptRegisterDialogModel');

  void onSignUpWithEmailTap() {
    _logger.i('onSignUpWithEmailTap');
    _navigationService.navigateTo(
      Routes.registerView,
      preventDuplicates: false,
      arguments: const RegisterViewArguments(navigatedFromRegisterPrompt: true),
    );
  }
}
