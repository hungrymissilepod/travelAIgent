import 'package:flutter/material.dart';
import 'package:separated_column/separated_column.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/average_price_section/average_price_section_view.dart';
import 'package:travel_aigent/ui/views/plan/plan_viewmodel.dart';
import 'package:travel_aigent/ui/views/plan/ui/at_a_glace_section_view.dart';
import 'package:travel_aigent/ui/views/plan/ui/attraction_view.dart';

class PlanViewLoadedState extends ViewModelWidget<PlanViewModel> {
  const PlanViewLoadedState({super.key});

  @override
  Widget build(BuildContext context, PlanViewModel viewModel) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 0, scaffoldHorizontalPadding, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jake, you'll love ${viewModel.plan?.city ?? ''}",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Image.network(viewModel.plan?.imageUrl ?? '',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover, errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    /// TODO: show image load error here
                    return Container(
                      height: 250,
                      color: Colors.grey,
                      child: Center(
                        child: Text(
                          'failed to load image for: ${viewModel.plan?.imageUrl}',
                        ),
                      ),
                    );
                  }),
                ),
              ),

              /// TODO: make 16 and 30 constant spacer widgets
              /// TODO: make description title and subtitle a widget
              /// TODO: clean up PlanView and other classes
              const SizedBox(height: 16),
              const AtAGlaceSectionView(),
              const SizedBox(height: 30),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 16),
              Text('${viewModel.plan?.description}'),
              const SizedBox(height: 16),
              AveragePriceSectionView(
                plan: viewModel.plan,
                exchangeRateData: viewModel.exchangeRateData,
              ),
              const SizedBox(height: 16),

              /// TODO: could show some fun facts about the place?
              const Text(
                'Things to do',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 16),
              SeparatedColumn(
                children: viewModel.plan?.attractions == null
                    ? <Widget>[]
                    : viewModel.plan!.attractions.map((e) => AttractionView(attraction: e)).toList(),
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Divider(
                      height: 32,
                      thickness: 1,
                    ),
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
