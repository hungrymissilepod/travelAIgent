import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_view.dart';

import 'average_price_section_viewmodel.dart';

class AveragePriceSectionView extends StackedView<AveragePriceSectionViewModel> {
  const AveragePriceSectionView({
    Key? key,
    required this.plan,
  }) : super(key: key);

  final Plan? plan;

  @override
  Widget builder(
    BuildContext context,
    AveragePriceSectionViewModel viewModel,
    Widget? child,
  ) {
    return Visibility(
      visible: !viewModel.hasError,
      child: InfoSectionView(
        title: 'Local prices',
        initiallyExpanded: false,
        subtitle: const AveragePriceSubtitle(),
        isLoading: viewModel.isBusy,
        hasError: viewModel.hasError,
        leftColumn: <Widget>[
          PlanViewDetailRow(
            icon: FontAwesomeIcons.moneyBillTransfer,
            label: viewModel.currencyConversionLabel,
          ),
          PlanViewDetailRow(
            icon: FontAwesomeIcons.utensils,
            label: viewModel.dinnerLabel,
          ),
        ],
        rightColumn: <Widget>[
          PlanViewDetailRow(
            icon: Icons.sports_bar,
            label: viewModel.beerLabel,
          ),
          PlanViewDetailRow(
            icon: FontAwesomeIcons.mugHot,
            label: viewModel.coffeeLabel,
          ),
        ],
      ),
    );
  }

  @override
  AveragePriceSectionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AveragePriceSectionViewModel();

  @override
  void onViewModelReady(AveragePriceSectionViewModel viewModel) => viewModel.init(plan);
}

class AveragePriceSubtitle extends StatelessWidget {
  const AveragePriceSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.solidCircleQuestion,
              color: Colors.grey,
              size: 14,
            ),
            SizedBox(width: 10),
            Text(
              'Local prices are based on estimates',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
