import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class CoinPairHeader extends StatelessWidget {
  const CoinPairHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
      color: palette.cardColor,
      child: Column(
        children: [
          Row(
            children: [
              const _CoinPairIcons(),
              const Gap(8),
              const CustomText(
                text: "BTC/USDT",
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              const Gap(16),
              CustomIcon(
                iconPath: AppAssets.dropDown,
                width: 10,
                height: 9,
                color: Theme.of(context).colorScheme.primary,
              ),
              const Gap(16),
              CustomText(
                text: "\$20,634",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: palette.candleStickGainColor,
              ),
            ],
          ),
          const Gap(20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _ItemColumn(
                  icon: AppAssets.clock,
                  label: "24h change",
                  description: "520.80 +1.25%",
                  color: palette.candleStickGainColor,
                ),
                const _Divider(),
                _ItemColumn(
                  icon: AppAssets.arrowUp,
                  label: "24h high",
                  description: "520.80 +1.25%",
                  color: palette.candleStickGainColor,
                ),
                const _Divider(),
                _ItemColumn(
                  icon: AppAssets.arrowDown,
                  label: "24h low",
                  description: "520.80 +1.25%",
                  color: palette.candleStickGainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinPairIcons extends StatelessWidget {
  const _CoinPairIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 44,
      child: Stack(
        children: [
          CustomIcon(
            iconPath: AppAssets.btc,
            width: 24,
            height: 24,
          ),
          Positioned(
            right: 1,
            child: CustomIcon(
              iconPath: AppAssets.usdt,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(4),
        VerticalDivider(
          width: 42,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const Gap(4),
      ],
    );
  }
}

class _ItemColumn extends StatelessWidget {
  final String icon;
  final String label;
  final String description;
  final Color? color;

  const _ItemColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIcon(
              iconPath: icon,
              width: 16,
              height: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const Gap(4),
            CustomText(
              text: label,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
        const Gap(6),
        CustomText(
          text: description,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
