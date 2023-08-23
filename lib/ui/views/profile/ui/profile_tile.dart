import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.label,
    this.icon,
    required this.onTap,
    this.labelStyle,
  });

  final String label;
  final IconData? icon;
  final Function() onTap;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label,
              style: labelStyle ??
                  const TextStyle(
                    fontSize: 20,
                  ),
            ),
            icon != null
                ? FaIcon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
