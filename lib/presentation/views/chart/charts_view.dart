import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/models/kline_candle.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/chart/charts_view_model.dart';
import 'package:sissyphus/presentation/views/chart/full_charts_view.dart';
import 'package:sissyphus/presentation/views/chart/widgets/trade_duration_list_view.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';
import 'package:sissyphus/presentation/widgets/reactive_builder.dart';

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
                child: Consumer(
                  builder: (context, ref, _) {
                    return ReactiveBuilder<List<KlineCandle>>(
                        value: ref.read(chartsViewModelProvider).candles,
                        builder: (candles) {
                          return Candlesticks(
                            candles: List<Candle>.from(
                              candles.map(
                                (e) => Candle(
                                  date: e.date,
                                  high: e.high,
                                  low: e.low,
                                  open: e.open,
                                  close: e.close,
                                  volume: e.volume,
                                ),
                              ),
                            ),
                          );
                        });
                  },
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
