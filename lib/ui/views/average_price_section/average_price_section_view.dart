import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_detail_row.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_error_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/info_section/info_section_loading_state.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';

import 'average_price_section_viewmodel.dart';

class AveragePriceSectionView
    extends StackedView<AveragePriceSectionViewModel> {
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
      visible:
          viewModel.hasError == false && viewModel.exchangeRateData != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Local prices',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: smallSpacer),
          viewModel.hasError
              ? const InfoSectionErrorState()
              : viewModel.isBusy
                  ? const InfoSectionLoadingState()
                  : Column(
                      children: <Widget>[
                        const AveragePriceSubtitle(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PlanViewDetailRow(
                                  icon: FontAwesomeIcons.moneyBillTransfer,
                                  label: viewModel.currencyConversionLabel,
                                ),
                                const SizedBox(height: 10),
                                PlanViewDetailRow(
                                  icon: FontAwesomeIcons.utensils,
                                  label: viewModel.dinnerLabel,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PlanViewDetailRow(
                                  icon: Icons.sports_bar,
                                  label: viewModel.beerLabel,
                                ),
                                const SizedBox(height: 10),
                                PlanViewDetailRow(
                                  icon: FontAwesomeIcons.mugHot,
                                  label: viewModel.coffeeLabel,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
  void onViewModelReady(AveragePriceSectionViewModel viewModel) =>
      viewModel.init(plan);
}

class AveragePriceSubtitle extends StatelessWidget {
  const AveragePriceSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.solidCircleQuestion,
              color: Colors.grey.shade600,
              size: 14,
            ),
            const SizedBox(width: 10),
            Text(
              'Local prices are based on estimates',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
