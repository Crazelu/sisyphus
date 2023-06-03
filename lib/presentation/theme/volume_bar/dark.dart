import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/volume_bar/base_theme.dart';

class DarkVolumeBarTheme implements VolumeBarTheme {
  const DarkVolumeBarTheme();

  @override
  Color get gainBorderColor => const Color(0xff58BD7D);

  @override
  Color get gainColor => const Color(0xff31413C);

  @override
  Color get lossBorderColor => const Color(0xffFF6838);

  @override
  Color get lossColor => const Color(0xff4A2C25);

  @override
  ThemeExtension<VolumeBarTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<VolumeBarTheme> lerp(
      covariant ThemeExtension<VolumeBarTheme>? other, double t) {
    return this;
  }

  @override
  Object get type => DarkVolumeBarTheme;
}
