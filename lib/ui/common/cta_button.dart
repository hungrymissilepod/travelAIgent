import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

enum CTAButtonStyle { fill, outline }

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.onTap,
    required this.label,
    this.style = CTAButtonStyle.fill,
    this.enabled = true,
    this.isLoading = false,
  });

  final Function() onTap;
  final String label;
  final CTAButtonStyle style;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (enabled) {
          if (!isLoading) {
            onTap();
          }
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          enabled
              ? style == CTAButtonStyle.fill
                  ? Colours.accent
                  : Colors.white
              : Colors.grey,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: style == CTAButtonStyle.fill ? Colors.transparent : Colours.accent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        overlayColor: MaterialStateProperty.all(
          enabled
              ? style == CTAButtonStyle.fill
                  ? Colours.accent[700]
                  : Colours.accent[100]
              : Colors.grey,
        ),
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: style == CTAButtonStyle.fill ? Colors.white : Colours.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 21,
                  ),
                ),
        ),
      ),
    );
  }
}
