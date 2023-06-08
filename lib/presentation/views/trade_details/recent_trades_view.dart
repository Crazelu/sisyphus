import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class RecentTradesView extends StatelessWidget {
  const RecentTradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Theme.of(context).extension<Palette>()!.cardColor,
      child: const Column(
        children: [
          Gap(8 * 8),
          CustomText(
            text: "No Recent Trades",
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          Gap(52),
        ],
      ),
    );
  }
}
