// text style
import 'dart:ui';

import 'package:flutter/material.dart';

const TextStyle kHeading5 =
    TextStyle(fontSize: 23, fontWeight: FontWeight.w400);
const TextStyle kHeading6 =
    TextStyle(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15);
const TextStyle kSubtitle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15);
const TextStyle kBodyText =
    TextStyle(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
const TextStyle kCaptionText =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.25);
const TextStyle kButton =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.25);
const TextStyle kOverline =
    TextStyle(fontSize: 10, fontWeight: FontWeight.w300, letterSpacing: 0.25);

// text theme
const kTextTheme = TextTheme(
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
  caption: kCaptionText,
  button: kButton,
  overline: kOverline,
);
