import 'package:flutter/material.dart';

abstract class VolumeBarTheme extends ThemeExtension<VolumeBarTheme> {
  Color get gainColor;
  Color get gainBorderColor;
  Color get lossColor;
  Color get lossBorderColor;
}
