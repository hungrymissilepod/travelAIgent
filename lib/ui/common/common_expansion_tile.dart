import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonExpansionTile extends StatefulWidget {
  const CommonExpansionTile({
    super.key,
    this.initiallyExpanded = true,
    required this.title,
    required this.children,
  });

  final bool initiallyExpanded;
  final String title;
  final List<Widget> children;

  @override
  State<CommonExpansionTile> createState() => _CommonExpansionTileState();
}

class _CommonExpansionTileState extends State<CommonExpansionTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent, splashColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
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
        children: widget.children,
      ),
    );
  }
}
