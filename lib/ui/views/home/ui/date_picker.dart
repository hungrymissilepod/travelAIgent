import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/misc/date_time_formatter.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_viewmodel.dart';

class DatePicker extends ViewModelWidget<HomeViewModel> {
  const DatePicker({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
          height: homePickerHeight,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 2,
              ),
              FaIcon(
                FontAwesomeIcons.calendarDays,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
              const SizedBox(width: 13),
              Text(
                '${viewModel.fromDate.datePickerFormat()} - ${viewModel.toDate.datePickerFormat()}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
