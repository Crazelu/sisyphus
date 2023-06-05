import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/palette.dart';

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
      ),
    );
  }
}
