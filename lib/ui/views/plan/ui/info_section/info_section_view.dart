import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_error_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_loaded_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_loading_state.dart';

class InfoSectionView extends StatefulWidget {
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
  State<InfoSectionView> createState() => _InfoSectionViewState();
}

class _InfoSectionViewState extends State<InfoSectionView> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, splashColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        initiallyExpanded: widget.initiallyExpanded,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        trailing: AnimatedRotation(
          turns: _isExpanded ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 150),
          child: const FaIcon(
            FontAwesomeIcons.chevronDown,
          ),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: <Widget>[
          widget.hasError
              ? const InfoSectionErrorState()
              : widget.isLoading
                  ? const InfoSectionLoadingState()
                  : InfoSectionLoadedState(
                      subtitle: widget.subtitle,
                      leftColumn: widget.leftColumn,
                      rightColumn: widget.rightColumn,
                    ),
        ],
      ),
    );
  }
}
