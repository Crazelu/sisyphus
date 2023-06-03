import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/volume_bar/base_theme.dart';

class LightVolumeBarTheme implements VolumeBarTheme {
  const LightVolumeBarTheme();

  @override
  Color get gainBorderColor => const Color(0xff25C26E);

  @override
  Color get gainColor => const Color(0xff004933).withOpacity(.5);

  @override
  Color get lossBorderColor => const Color(0xffFF6838);

  @override
  Color get lossColor => const Color(0xff9B1D00).withOpacity(.5);

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
  Object get type => LightVolumeBarTheme;
}
