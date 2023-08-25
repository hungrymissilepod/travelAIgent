import 'package:flutter/material.dart';

class RefreshIcon extends StatefulWidget {
  const RefreshIcon({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  State<RefreshIcon> createState() => _RefreshIconState();
}

class _RefreshIconState extends State<RefreshIcon> {
  final Duration delay = const Duration(milliseconds: 250);
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _isTapped ? 0.75 : 0.0,
      duration: delay,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _isTapped = true;
          });
          await Future.delayed(delay);
          widget.onTap();
        },
        child: const Icon(
          Icons.refresh_rounded,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
