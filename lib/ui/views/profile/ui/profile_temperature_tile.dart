import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/ui/views/profile/profile_viewmodel.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_item_header.dart';

class ProfileTemperatureTile extends ViewModelWidget<ProfileViewModel> {
  const ProfileTemperatureTile({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ProfileItemHeader(
            label: 'Temperature unit',
          ),
          InkWell(
            onTap: () =>
                viewModel.setMeasurementSystem(MeasurementSystem.metric),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Celcius (°C)',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Radio<MeasurementSystem>(
                  value: MeasurementSystem.metric,
                  groupValue: viewModel.whoAmI.measurementSystem,
                  onChanged: (MeasurementSystem? value) {
                    viewModel.setMeasurementSystem(value!);
                  },
                  visualDensity: const VisualDensity(horizontal: -4),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () =>
                viewModel.setMeasurementSystem(MeasurementSystem.imperial),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Farenheit (°F)',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Radio<MeasurementSystem>(
                  value: MeasurementSystem.imperial,
                  groupValue: viewModel.whoAmI.measurementSystem,
                  onChanged: (MeasurementSystem? value) {
                    viewModel.setMeasurementSystem(value!);
                  },
                  visualDensity: const VisualDensity(horizontal: -4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
