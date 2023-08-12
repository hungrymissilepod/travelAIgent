import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class TravellerCounterButton extends StatelessWidget {
  const TravellerCounterButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          splashColor: Colours.accent.shade700,
          onTap: onTap,
          child: SizedBox(
            height: 28,
            width: 28,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
