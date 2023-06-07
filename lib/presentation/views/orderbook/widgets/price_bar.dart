import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class Pricebar extends StatelessWidget {
  final double newPrice;
  final double oldPrice;

  const Pricebar({
    super.key,
    required this.newPrice,
    required this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    Color color = newPrice > oldPrice
        ? palette.buyButtonColor
        : newPrice < oldPrice
            ? palette.sellPriceColor
            : Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: newPrice.toString(),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        const Gap(8),
        CustomIcon(
          iconPath: AppAssets.arrowUp,
          color: color,
          width: 18,
          height: 18,
        ),
        const Gap(8),
        CustomText(
          text: oldPrice.toString(),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
