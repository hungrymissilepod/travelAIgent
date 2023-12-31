import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

class PlanViewErrorState extends StatelessWidget {
  const PlanViewErrorState({super.key, required this.retry});

  final Future<void> Function() retry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 4, child: Container()),
          const Image(
            image: AssetImage('assets/caution.png'),
            width: 180,
            height: 180,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Sorry, we failed to generate a trip.\nLet's try again!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CTAButton(
            onTap: () => retry(),
            label: 'Try again',
          ),
          Expanded(flex: 5, child: Container()),
        ],
      ),
    );
  }
}
