import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/palette.dart';

class DarkPalette implements Palette {
  const DarkPalette();

  @override
  Color get selectedTimeChipColor => const Color(0xff555C63);
  @override
  Color get selectedTabChipColor => const Color(0xff262B33);
  @override
  Color get tabBackgroundColor => const Color(0xff1C2127);
  @override
  Color get selectedTabTextColor => const Color(0xffFFFFFF);
  @override
  Color get unselectedTabTextColor => const Color(0xffFFFFFF);
  @override
  Color get appBarTitleColor => const Color(0xffFFFFFF);
  @override
  Color get buyButtonColor => const Color(0xff25C26E);
  @override
  Color get sellButtonColor => const Color(0xffFF554A);
  @override
  Color get sellPriceColor => const Color(0xffFF6838);
  @override
  Color get selectedMenuItemBackgroundColor => const Color(0xff252A30);
  @override
  Color get dropDownBackgroundColor => const Color(0xff353945);
  @override
  Color get bottomSheetBackgroundColor => const Color(0xff20252B);
  @override
  Color get candleStickGainColor => const Color(0xff00C076);
  @override
  Color get candleStickLossColor => const Color(0xffFF6838);

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
  Object get type => DarkPalette;
}