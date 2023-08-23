import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/profile/profile_viewmodel.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_item_header.dart';

class ProfileCheatSection extends ViewModelWidget<ProfileViewModel> {
  const ProfileCheatSection({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        const ProfileItemHeader(
          label: 'Cheats',
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => viewModel.testOnBoarding(),
          child: const Text(
            'Test OnBoardingCarousel',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => viewModel.onDestinationValidationTapped(),
          child: Text(
            'Destination validation disabled: ${viewModel.destinationValidationDisabled}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const Divider(thickness: 0.6),
      ],
    );
  }
}
