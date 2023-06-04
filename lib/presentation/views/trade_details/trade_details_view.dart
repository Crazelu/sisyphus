import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/views/trade_details/widgets/app_bar.dart';
import 'package:sissyphus/presentation/views/trade_details/widgets/coin_pair_header.dart';
import 'package:sissyphus/presentation/views/trade_details/widgets/trading_activity_section.dart';

class TradeDetailsView extends StatelessWidget {
  const TradeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
      appBar: CustomAppBar(
        color: palette.cardColor,
        logoPath: palette.logoPath,
      ),
      body: SizedBox.expand(
        child: ListView(
          children: [
            const Gap(8),
            const CoinPairHeader(),
            const Gap(12),
            const TradingActivitySection(),
          ],
        ),
      ),
    );
  }
}
