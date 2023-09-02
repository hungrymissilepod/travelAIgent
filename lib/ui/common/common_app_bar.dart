import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.onTitleTap,
    this.centerTitle = true,
    this.showBackButton = false,
    this.onLeadingTap,
  });

  final String title;
  final Function? onTitleTap;
  final bool centerTitle;
  final bool showBackButton;
  final Function? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: centerTitle,
      title: GestureDetector(
        onTap: () => onTitleTap?.call(),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      leading: showBackButton
          ? GestureDetector(
              onTap: () {
                if (onLeadingTap != null) {
                  onLeadingTap?.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: 30,
              ),
            )
          : const SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
