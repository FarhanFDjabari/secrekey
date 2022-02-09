import 'package:flutter/material.dart';
import 'package:secrekey/styles/text_styles.dart';

const Color cMilkyGreyBlue = Color(0xFF758EB5);
const Color cBaseBlack = Color(0xFF01020A);
const Color cMistyWhite = Color(0xFFEDEDED);
const Color cLightGreyBlue = Color(0xFF65799B);
const Color cDarkGreyBlue = Color(0xFF323555);
const Color cNeonBlue = Color(0xFF0B1EDF);
const Color cDarkerNeonBlue = Color(0xFF0B1E96);
const Color cLightMilkyPink = Color(0xFFB07E93);
const Color cTealGreen = Color(0xFF179E99);

const kColorScheme = ColorScheme(
  primary: cNeonBlue,
  inversePrimary: cDarkerNeonBlue,
  secondary: cLightGreyBlue,
  secondaryContainer: cDarkGreyBlue,
  surface: cDarkGreyBlue,
  background: cBaseBlack,
  error: Colors.red,
  onPrimary: cNeonBlue,
  onSecondary: cDarkGreyBlue,
  onSurface: cDarkGreyBlue,
  onBackground: cBaseBlack,
  onError: Colors.red,
  brightness: Brightness.light,
);

final kThemeLight = ThemeData.light().copyWith(
  colorScheme: kColorScheme,
  brightness: Brightness.light,
  textTheme: kTextTheme,
);

final kThemeDark = ThemeData.dark().copyWith();
