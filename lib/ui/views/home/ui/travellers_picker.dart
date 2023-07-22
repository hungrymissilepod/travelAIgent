import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/home/home_view.dart';
import 'package:travel_aigent/ui/views/home/home_viewmodel.dart';
import 'package:travel_aigent/ui/views/home/ui/traveller_counter_button.dart';

class TravellersPicker extends ViewModelWidget<HomeViewModel> {
  const TravellersPicker({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: homePickerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 2,
              ),
              FaIcon(
                FontAwesomeIcons.personWalkingLuggage,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
              const SizedBox(width: 10),
              Text(
                'Travellers',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              TravellerCounterButton(
                onTap: () => viewModel.decrementTravellers(),
                child: const FaIcon(
                  FontAwesomeIcons.minus,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${viewModel.travellers}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 14),
                ),
              ),
              TravellerCounterButton(
                onTap: () => viewModel.incrementTravellers(),
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
