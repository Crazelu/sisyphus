import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/trade_details/trade_details_view_model.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';
import 'package:sissyphus/presentation/widgets/reactive_builder.dart';

class CoinPairHeader extends StatelessWidget {
  const CoinPairHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Consumer(builder: (context, ref, _) {
      return ReactiveBuilder(
          value: ref.read(tradeDetailsViewModelProvider).tradeData,
          builder: (tradeData) {
            return Container(
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              color: palette.cardColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      const _CoinPairIcons(),
                      const Gap(8),
                      CustomText(
                        text: tradeData.symbol,
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
                        text: "\$${tradeData.currentPrice}",
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
                          description:
                              "${tradeData.priceChangeIn24H.toStringAsFixed(2)} ${tradeData.isPriceChangeIn24HNeg ? '-' : '+'} ${tradeData.percentageChangeIn24H.toStringAsFixed(2)}%",
                          color: tradeData.isPriceChangeIn24HNeg
                              ? palette.candleStickLossColor
                              : palette.candleStickGainColor,
                        ),
                        const _Divider(),
                        _ItemColumn(
                          icon: AppAssets.arrowUp,
                          label: "24h high",
                          description: tradeData.highPrice,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const _Divider(),
                        _ItemColumn(
                          icon: AppAssets.arrowDown,
                          label: "24h low",
                          description: tradeData.lowPrice,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
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
        Align(
          alignment: Alignment.center,
          child: CustomText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
