import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/views/chart/charts_view_model.dart';
import 'package:sissyphus/presentation/widgets/custom_chip.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class TradeDurationListView extends StatefulWidget {
  const TradeDurationListView({super.key});

  @override
  State<TradeDurationListView> createState() => _TradeDurationListViewState();
}

class _TradeDurationListViewState extends State<TradeDurationListView> {
  String? _selectedLabel;

  void _setSelectedLabel(String value) {
    if (_selectedLabel != value) {
      ProviderScope.containerOf(context)
          .read(chartsViewModelProvider)
          .updateInterval(value);
      setState(() {
        _selectedLabel = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        _selectedLabel = ProviderScope.containerOf(context)
            .read(chartsViewModelProvider)
            .currentKlineInterval
            .toUpperCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CustomText(
            text: "Time",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Gap(2),
          for (final label in ref.read(chartsViewModelProvider).intervals)
            CustomChip(
              label: label,
              selected: label == _selectedLabel,
              onPressed: _setSelectedLabel,
            ),
          const Gap(8),
          CustomIcon(
            iconPath: AppAssets.dropDown,
            width: 10,
            height: 9,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Gap(8),
          VerticalDivider(
            color: Theme.of(context).colorScheme.secondary,
            width: 10,
          ),
          CustomIcon(
            iconPath: AppAssets.candleChart,
            width: 20,
            height: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.secondary,
            width: 10,
          ),
          const Gap(4),
          const CustomChip(
            label: "Fx Indicators",
            disableWidth: true,
          ),
        ],
      );
    });
  }
}
