import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_viewmodel.dart';
import 'package:travel_aigent/ui/views/saved_plans/ui/plan_native_ad_view.dart';
import 'package:travel_aigent/ui/views/saved_plans/ui/saved_plan_card.dart';

class SavedPlanViewLoadedState extends ViewModelWidget<SavedPlansViewModel> {
  const SavedPlanViewLoadedState({
    super.key,
    required this.type,
  });

  final TemplateType type;

  @override
  Widget build(BuildContext context, SavedPlansViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
          child: SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: viewModel.savedPlans.map((e) => SavedPlanCard(plan: e)).toList(),
            separatorBuilder: (context, index) {
              if (index.isOdd) {
                return PlanNativeAdView(type: type);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
