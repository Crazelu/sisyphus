import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/chart/charts_view_model.dart';
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
            _DurationChip(
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
          const _DurationChip(
            label: "Fx Indicators",
            disableWidth: true,
          ),
        ],
      );
    });
  }
}

class _DurationChip extends StatelessWidget {
  final String label;
  final Function(String)? onPressed;
  final bool selected;
  final bool disableWidth;
  const _DurationChip({
    super.key,
    required this.label,
    this.selected = false,
    this.disableWidth = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onPressed?.call(label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: disableWidth ? null : 40,
        height: 28,
        decoration: BoxDecoration(
          color: selected ? palette.selectedTimeChipColor : null,
          borderRadius: selected ? BorderRadius.circular(100) : null,
        ),
        child: Center(
          child: CustomText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
