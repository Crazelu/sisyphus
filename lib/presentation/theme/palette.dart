import 'package:flutter/material.dart';

abstract class Palette extends ThemeExtension<Palette> {
  Color get selectedTimeChipColor;
  Color get selectedTabChipColor;
  Color get tabBackgroundColor;
  Color get selectedTabTextColor;
  Color get unselectedTabTextColor;
  Color get appBarTitleColor;
  Color get buyButtonColor;
  Color get sellButtonColor;
  Color get sellPriceColor;
  Color get selectedMenuItemBackgroundColor;
  Color get dropDownBackgroundColor;
  Color get bottomSheetBackgroundColor;
  Color get candleStickGainColor;
  Color get candleStickLossColor;
  Color get cardColor;
}
