import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeModeSelector {
  ThemeModeSelector._();

  static final ValueNotifier<ThemeMode> _mode = ValueNotifier(ThemeMode.system);

  static ValueNotifier<ThemeMode> get mode => _mode;

  static void toggleMode() {
    final currentMode = _mode.value;
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (currentMode == ThemeMode.system) {
      if (brightness == Brightness.dark) {
        _mode.value = ThemeMode.light;
      } else {
        _mode.value = ThemeMode.dark;
      }
    } else {
      if (currentMode == ThemeMode.dark) {
        _mode.value = ThemeMode.light;
      } else {
        _mode.value = ThemeMode.dark;
      }
    }
  }
}
