import 'package:flutter/material.dart';

class TravellerCounterButton extends StatelessWidget {
  const TravellerCounterButton({super.key, required this.child, required this.onTap});

  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
