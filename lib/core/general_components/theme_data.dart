import 'package:flutter/material.dart';

import 'ColorHelper.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: const AppBarTheme(color: ColorHelper.mainColor),
    scaffoldBackgroundColor: ColorHelper.darkColor,
    drawerTheme: const DrawerThemeData(
        backgroundColor: ColorHelper.darkColor,
        surfaceTintColor: ColorHelper.darkColor),
    colorScheme: ColorScheme.fromSeed(seedColor: ColorHelper.mainColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        backgroundColor: const MaterialStatePropertyAll(ColorHelper.mainColor),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        textStyle:
            const MaterialStatePropertyAll(TextStyle(color: Colors.white)),
        overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(.1)),
      ),
    ),
  );
}
