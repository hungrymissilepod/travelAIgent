import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'delete_user_dialog_model.dart';

class DeleteUserDialog extends StackedView<DeleteUserDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteUserDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DeleteUserDialogModel viewModel,
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
              'Delete Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.red,
              ),
            ),
            viewModel.hasErrorForKey(DeleteAccountDialogSection.failedToDelete)
                ? const _DeleteAccountDialogErrorState()
                : viewModel.isBusy
                    ? const _DeleteAccountDialogLoadingState()
                    : const _DeleteAccountDialogLoadedState(),
          ],
        ),
      ),
    );
  }

  @override
  DeleteUserDialogModel viewModelBuilder(BuildContext context) => DeleteUserDialogModel();
}

class _DeleteAccountDialogLoadedState extends ViewModelWidget<DeleteUserDialogModel> {
  const _DeleteAccountDialogLoadedState();

  @override
  Widget build(BuildContext context, DeleteUserDialogModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Are you sure you want to delete your account and all data? This action cannot be undone.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              onPressed: () => viewModel.onCancelTap(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              width: 140,
              child: CTAButton(
                onTap: () => viewModel.deleteUser(),
                label: 'Delete',
                overrideColor: Colors.red,
                isLoading: viewModel.isBusy,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DeleteAccountDialogErrorState extends ViewModelWidget<DeleteUserDialogModel> {
  const _DeleteAccountDialogErrorState();

  @override
  Widget build(BuildContext context, DeleteUserDialogModel viewModel) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          viewModel.getErrorMessage(),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 140,
              child: CTAButton(
                onTap: () => viewModel.onErrorButtonTapped(),
                label: viewModel.getButtonErrorLabel(),
                overrideColor: Colors.red,
                isLoading: viewModel.isBusy,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DeleteAccountDialogLoadingState extends StatelessWidget {
  const _DeleteAccountDialogLoadingState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 150,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
