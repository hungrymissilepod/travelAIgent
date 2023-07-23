import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

enum CTAButtonStyle { fill, outline }

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.onTap,
    required this.label,
    this.style = CTAButtonStyle.fill,
  });

  final Function() onTap;
  final String label;
  final CTAButtonStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: style == CTAButtonStyle.fill ? Colours.accent : Colors.white,
          border: Border.all(
            color: Colours.accent,
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            label,
            style: TextStyle(
              color:
                  style == CTAButtonStyle.fill ? Colors.white : Colours.accent,
              fontWeight: FontWeight.w700,
              fontSize: 21,
            ),
          ),
        )),
      ),
    );
  }
}
