import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/models/kline_candle.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/chart/charts_view_model.dart';
import 'package:sissyphus/presentation/widgets/reactive_builder.dart';
import 'package:sissyphus/utils/app_strings.dart';

class FullChartsView extends StatelessWidget {
  const FullChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      backgroundColor: palette.cardColor,
      appBar: AppBar(
        backgroundColor: palette.cardColor,
        elevation: 0,
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Consumer(
            builder: (context, ref, _) {
              return ReactiveBuilder<List<KlineCandle>>(
                  value: ref.read(chartsViewModelProvider).candles,
                  builder: (candles) {
                    if (candles.length < 14) return const SizedBox();
                    return Candlesticks(
                      symbol: AppStrings.symbol,
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
      ),
    );
  }
}
