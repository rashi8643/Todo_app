import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/core/theme/color_palette.dart';
import 'package:samsidh_task/core/theme/extentions/colors_extention.dart';
import 'package:samsidh_task/core/theme/extentions/spaces_extention.dart';
import 'package:samsidh_task/core/theme/extentions/typography_extention.dart';

part 'light_theme.g.dart';

final _lightTheme = ThemeData(brightness: Brightness.light, extensions: [
  AppColorExtension(
    primary: AppColorPalette.primary,
    secondary: Colors.white,
    text: Colors.black,
    textInverse: AppColorPalette.secondary,
    textSubtle: AppColorPalette.sub,
    textSubtlest: Colors.white,
    backgroundDanger: AppColorPalette.backGround,
  ),
  AppSpaceExtension.fromBaseSpace(8),
  AppTypographyExtension.fromColors(
    defaultFontColor: AppColorPalette.secondary,
    linkColor: Colors.blue,
    dimFontColor: Colors.black,
  )
]);

@riverpod
ThemeData lightTheme(LightThemeRef ref) {
  return _lightTheme;
}