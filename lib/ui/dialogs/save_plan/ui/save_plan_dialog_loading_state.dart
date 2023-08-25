import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class SavePlanDialogLoadingState extends StatelessWidget {
  const SavePlanDialogLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(color: Colours.accent),
            const SizedBox(height: 20),
            Text(
              'Saving your trip',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
