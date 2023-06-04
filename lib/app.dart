import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/dark_palette.dart';
import 'package:sissyphus/presentation/theme/light_palette.dart';
import 'package:sissyphus/presentation/theme/theme_mode_selector.dart';
import 'package:sissyphus/presentation/theme/volume_bar/dark.dart';
import 'package:sissyphus/presentation/theme/volume_bar/light.dart';
import 'package:sissyphus/presentation/views/trade_details/trade_details_view.dart';

class SissyphusApp extends StatelessWidget {
  const SissyphusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeModeSelector.mode,
        builder: (context, themeMode, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sissyphus',
            themeMode: themeMode,
            darkTheme: ThemeData(
              extensions: const <ThemeExtension<dynamic>>{
                DarkPalette(),
                DarkVolumeBarTheme(),
              },
              primarySwatch: Colors.grey,
              scaffoldBackgroundColor: const Color(0xff262932),
              colorScheme: const ColorScheme.dark(
                primary: Color(0xffFFFFFF),
                secondary: Color(0xffA7B1BC),
                background: Color(0xff262932),
              ),
              fontFamily: "Satoshi",
            ),
            theme: ThemeData(
              extensions: const <ThemeExtension<dynamic>>{
                LightPalette(),
                LightVolumeBarTheme(),
              },
              primarySwatch: Colors.grey,
              scaffoldBackgroundColor: const Color(0xfff8f8f9),
              colorScheme: const ColorScheme.light(
                primary: Color(0xff1C2127),
                secondary: Color(0xff737A91),
                background: Color(0xfff8f8f9),
              ),
              fontFamily: "Satoshi",
            ),
            home: const TradeDetailsView(),
          );
        });
  }
}
