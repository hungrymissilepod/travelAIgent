import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'prompt_register_dialog_model.dart';

class PromptRegisterDialog extends StackedView<PromptRegisterDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PromptRegisterDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PromptRegisterDialogModel viewModel,
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
              'Create an account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                'In order to save trips you need to create an account',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            CTAButton(
              onTap: () async {
                /// If the user completed the register screen and creatd an account
                if (await viewModel.onSignUpWithEmailTap()) {
                  completer(DialogResponse(confirmed: true));
                }
              },
              label: 'Sign Up with Email',
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: Divider(
            //           color: Colors.grey,
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 20),
            //         child: Text(
            //           'or',
            //           style: TextStyle(
            //             color: Colors.grey,
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: Divider(
            //           color: Colors.grey,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // CTAButton(
            //   onTap: () {},
            //   label: 'Sign in',
            //   style: CTAButtonStyle.outline,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  PromptRegisterDialogModel viewModelBuilder(BuildContext context) =>
      PromptRegisterDialogModel();
}
