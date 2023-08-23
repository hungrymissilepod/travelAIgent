import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

class SavedPlanViewEmptyState extends StatelessWidget {
  const SavedPlanViewEmptyState({
    super.key,
    required this.navigateToHomeView,
  });

  final Function() navigateToHomeView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset('assets/lost.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your Saved Trips list is empty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Generate trips to save them here',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          CTAButton(
            onTap: () => navigateToHomeView(),
            label: 'Generate Trip',
          ),
        ],
      ),
    );
  }
}
