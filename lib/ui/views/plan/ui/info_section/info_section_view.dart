import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/common_expansion_tile.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_error_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_loaded_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_loading_state.dart';

class InfoSectionView extends StatelessWidget {
  const InfoSectionView({
    super.key,
    required this.title,
    this.initiallyExpanded = true,
    required this.leftColumn,
    required this.rightColumn,
    this.subtitle,
    this.isLoading = false,
    this.hasError = false,
  });

  final String title;
  final bool initiallyExpanded;
  final List<Widget> leftColumn;
  final List<Widget> rightColumn;
  final Widget? subtitle;
  final bool isLoading;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return CommonExpansionTile(
      title: title,
      children: <Widget>[
        hasError
            ? const InfoSectionErrorState()
            : isLoading
                ? const InfoSectionLoadingState()
                : InfoSectionLoadedState(
                    subtitle: subtitle,
                    leftColumn: leftColumn,
                    rightColumn: rightColumn,
                  ),
      ],
    );
  }
}
