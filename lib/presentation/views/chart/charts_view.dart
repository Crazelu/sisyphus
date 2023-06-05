import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/chart/full_charts_view.dart';
import 'package:sissyphus/presentation/views/chart/widgets/trade_duration_list_view.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(24),
          const SizedBox(
            height: 22,
            child: TradeDurationListView(),
          ),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomIcon(
              iconPath: AppAssets.expand,
              height: 17,
              width: 17,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FullChartsView(),
                  ),
                );
              },
            ),
          ),
          const Gap(16),
          Stack(
            children: [
              SizedBox(
                height: 390,
                width: MediaQuery.of(context).size.width,
                child: Candlesticks(
                  candles: List.generate(
                    18,
                    (index) => index < 13
                        ? Candle(
                            date: DateTime.now(),
                            high: 0,
                            low: 0,
                            open: 0,
                            close: 0,
                            volume: 0,
                          )
                        : Candle(
                            date: DateTime.now(),
                            high: 23,
                            low: 12,
                            open: 12,
                            close: 20,
                            volume: 100,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 14,
                  children: [
                    const SizedBox(width: 1),
                    CustomIcon(
                      iconPath: AppAssets.dropDownBordered,
                      height: 17,
                      width: 17,
                    ),
                    CustomText(
                      text: "BTC/USD",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const _PriceText(
                      label: "O",
                      price: "36,641.54",
                    ),
                    const _PriceText(
                      label: "H",
                      price: "36,641.54",
                    ),
                    const _PriceText(
                      label: "L",
                      price: "36,641.54",
                    ),
                    const _PriceText(
                      label: "C",
                      price: "36,641.54",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceText extends StatelessWidget {
  final String label;
  final String price;

  const _PriceText({
    super.key,
    required this.label,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
        children: [
          TextSpan(
            text: " $price",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).extension<Palette>()!.buyButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
