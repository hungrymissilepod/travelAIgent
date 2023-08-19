import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/ui/flexible_destinations/flexible_destination.dart';
import 'package:travel_aigent/ui/views/home/ui/flexible_destinations/flexible_destination_cell.dart';

class FlexibleDestinationExpansionTile extends StatefulWidget {
  const FlexibleDestinationExpansionTile({super.key});

  @override
  State<FlexibleDestinationExpansionTile> createState() => _FlexibleDestinationExpansionTileState();
}

class _FlexibleDestinationExpansionTileState extends State<FlexibleDestinationExpansionTile> {
  final ExpansionTileController controller = ExpansionTileController();

  bool checked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent, splashColor: Colors.transparent),
      child: ListTileTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
        dense: true,
        minLeadingWidth: 0,
        child: ExpansionTile(
          controller: controller,
          initiallyExpanded: false,
          trailing: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: checked,
              onChanged: (bool? newValue) {
                setState(() {
                  checked = newValue ?? false;
                  if (checked) {
                    controller.expand();
                  } else {
                    controller.collapse();
                  }
                });
              },
            ),
          ),
          title: Row(
            children: [
              const SizedBox(
                width: 2,
              ),
              Text(
                'I\'m flexible',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              checked = expanded;
            });
          },
          children: <Widget>[
            SizedBox(
              height: 50,
              child: ListView.separated(
                itemCount: flexibleDestinations.length,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    /// Add [scaffoldHorizontalPadding] to only the first and last cells
                    padding: EdgeInsets.only(
                      left: index == 0 ? scaffoldHorizontalPadding : 0,
                      right: index == flexibleDestinations.length - 1 ? scaffoldHorizontalPadding : 0,
                    ),
                    child: FlexibleDestinationCell(
                      label: flexibleDestinations[index].label,
                      icon: flexibleDestinations[index].icon,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
