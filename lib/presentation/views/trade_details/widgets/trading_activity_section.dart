import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_tab_bar.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class TradingActivitySection extends StatelessWidget {
  const TradingActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: palette.cardColor,
      child: Column(
        children: [
          const Gap(8),
          CustomTabBar(
            tabs: [
              "Charts",
              "Orderbook",
              "Recent trades",
            ],
          ),
          const Gap(16),
          SizedBox(
            height: 22,
            child: const _TradeDurationListView(),
          )
        ],
      ),
    );
  }
}

class _TradeDurationListView extends StatelessWidget {
  const _TradeDurationListView({super.key});

  @override
  Widget build(BuildContext context) {
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
        const _DurationChip(
          label: "1H",
          selected: false,
        ),
        const _DurationChip(
          label: "2H",
          selected: false,
        ),
        const _DurationChip(
          label: "4H",
          selected: false,
        ),
        const _DurationChip(
          label: "1D",
          selected: true,
        ),
        const _DurationChip(
          label: "1W",
          selected: false,
        ),
        const _DurationChip(
          label: "1M",
          selected: false,
        ),
        const Gap(4),
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
  }
}

class _DurationChip extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
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
      onTap: onPressed,
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
