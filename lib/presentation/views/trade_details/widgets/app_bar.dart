import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/theme_mode_selector.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';

class CustomAppBar extends AppBar {
  final Color color;
  final VoidCallback? onMenuPressed;
  final String logoPath;

  CustomAppBar({
    super.key,
    required this.color,
    required this.logoPath,
    this.onMenuPressed,
    super.elevation = 0,
  }) : super(
          backgroundColor: color,
          leadingWidth: 129,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CustomIcon(
              iconPath: logoPath,
              height: 34,
              width: 121,
            ),
          ),
          actions: [
            const CustomIcon(
              iconPath: AppAssets.avatar,
              height: 32,
              width: 32,
            ),
            const Gap(8),
            const CustomIcon(
              iconPath: AppAssets.globe,
              height: 24,
              width: 24,
              onPressed: ThemeModeSelector.toggleMode,
            ),
            const Gap(8),
            CustomIcon(
              iconPath: AppAssets.menu,
              height: 32,
              width: 32,
              onPressed: onMenuPressed,
            ),
            const Gap(8),
          ],
        );
}
