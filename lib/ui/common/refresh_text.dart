import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class RefreshText extends StatefulWidget {
  const RefreshText({
    super.key,
    required this.onTap,
    this.color = Colors.black,
  });

  final Function() onTap;
  final Color color;

  @override
  State<RefreshText> createState() => _RefreshTextState();
}

class _RefreshTextState extends State<RefreshText> {
  final Duration delay = const Duration(milliseconds: 250);
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStatePropertyAll(
        Colours.accent.shade100,
      ),
      onTap: () async {
        setState(() {
          _isTapped = true;
        });
        await Future.delayed(delay);
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedRotation(
              turns: _isTapped ? 0.75 : 0.0,
              duration: delay,
              child: Icon(
                Icons.refresh_rounded,
                size: 30,
                color: widget.color,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Get another suggestion',
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
