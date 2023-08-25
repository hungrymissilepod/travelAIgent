import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravellerCounterButton extends StatelessWidget {
  const TravellerCounterButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.enabled,
  });

  final Function() onTap;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: enabled ? () => onTap() : null,
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? Theme.of(context).primaryColor : Colors.grey.shade400,
          ),
        ),
        child: Center(
          child: FaIcon(
            icon,
            size: 12,
            color: enabled ? Theme.of(context).primaryColor : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
