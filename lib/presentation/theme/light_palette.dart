import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';

class LightPalette implements Palette {
  const LightPalette();

  @override
  Color get selectedTimeChipColor => const Color(0xffCFD3D8);
  @override
  Color get selectedTabChipColor => const Color(0xffFFFFFF);
  @override
  Color get tabBackgroundColor => const Color(0xffF1F1F1);
  @override
  Color get selectedTabTextColor => const Color(0xff1C2127);
  @override
  Color get unselectedTabTextColor => const Color(0xff737A91);
  @override
  Color get appBarTitleColor => const Color(0xff000000);
  @override
  Color get buyButtonColor => const Color(0xff25C26E);
  @override
  Color get sellButtonColor => const Color(0xffFF554A);
  @override
  Color get sellPriceColor => const Color(0xffFF6838);
  @override
  Color get selectedMenuItemBackgroundColor => const Color(0xffF1F1F1);
  @override
  Color get dropDownBackgroundColor => const Color(0xffCFD3D8);
  @override
  Color get bottomSheetBackgroundColor => const Color(0xffFFFFFF);
  @override
  Color get candleStickGainColor => const Color(0xff00C076);
  @override
  Color get candleStickLossColor => const Color(0xffFF6838);
  @override
  Color get cardColor => const Color(0xffFFFFFF);
  @override
  Color? get tabBorderColor => null;
  @override
  String get logoPath => AppAssets.lightLogo;

  @override
  ThemeExtension<Palette> copyWith() {
    return this;
  }

  @override
  ThemeExtension<Palette> lerp(
    covariant ThemeExtension<Palette>? other,
    double t,
  ) {
    return this;
  }

  @override
  Object get type => Palette;
}
