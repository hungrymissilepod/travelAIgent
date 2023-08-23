import 'package:flutter/material.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_item_header.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    this.showEditIcon = true,
  });

  final String title;
  final String content;
  final Function() onTap;
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProfileItemHeader(
                label: title,
              ),
              Visibility(
                visible: showEditIcon,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => onTap(),
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
