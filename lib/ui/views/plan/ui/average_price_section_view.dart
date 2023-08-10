import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_view.dart';

class AveragePriceSectionView extends ViewModelWidget<PlanViewModel> {
  const AveragePriceSectionView({super.key});

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return InfoSectionView(
      title: 'Local prices',
      initiallyExpanded: false,
      subtitle: const AveragePriceSubtitle(),
      isLoading: viewModel.busy(PlanViewSection.averagePrices),
      leftColumn: <Widget>[
        PlanViewDetailRow(
          icon: FontAwesomeIcons.moneyBillTransfer,
          label:
              '1 ${viewModel.ipLocation?.currencyCode} = ${viewModel.calculateExchangeInverse()} ${viewModel.plan?.currencyCode}',
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.utensils,
          label:
              'Dinner for two ${viewModel.currencySymbol}${viewModel.calculateItemPrice(viewModel.exchangeRateData?.dinner)}',
        ),
      ],
      rightColumn: <Widget>[
        PlanViewDetailRow(
          icon: Icons.sports_bar,
          label:
              'Pint of beer ${viewModel.currencySymbol}${viewModel.calculateItemPrice(viewModel.exchangeRateData?.beer)}',
        ),
        PlanViewDetailRow(
          icon: FontAwesomeIcons.mugHot,
          label:
              'Capuccino ${viewModel.currencySymbol}${viewModel.calculateItemPrice(viewModel.exchangeRateData?.capuccino)}',
        ),
      ],
    );
  }
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
              'Local prices are based on estimated averages',
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
