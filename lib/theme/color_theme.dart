import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorTheme {
  static const Color primary = Color(0xFF575A9D);
  static const Color primaryTint = Color(0xFF002F5E);
  static const Color primaryShade = Color(0xff7889a5);
  static const Color secondary = Color(0xff3FA57E);
  static const Color secondaryTint = Color(0xff76BB5A);
  static const Color tertiary = Color(0xff4BCBF1);
  static const Color tertiaryShade = Color(0xff1A8DBE);
  static const Color tertiaryTint = Color(0xff4C85FC);

  static const Color success = Color(0xff51D686);
  static const Color successTint = Color(0xff56D5A3);
  static const Color warning = Color(0xff8B4087);
  static const Color danger = Color(0xffF4917C);

  static const Color dark = Color(0xff1a1a1a);
  static const Color darkShade = Color(0xff364A66);
  static const Color darkOpaque = Color(0xff666666);

  static const Color medium = Color(0xff808080);
  static const Color mediumshade = Color(0xff717171);
  static const Color mediumtint = Color(0xffa6ada6);

  static const Color light = Color(0xffF2F2F2);
  static const Color darklight = Color(0xffE2E2E2);
  static const Color lightshade = Color(0xffF4F4F4);
  static const Color lighttint = Color(0xffD8D8D8);

  static const Color aomBackgroundColor = Color(0xffF6F4FC);

  static const LinearGradient backgroundGradient = LinearGradient(
    stops: [0.0, 0.4234],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.mirror,
    colors: <Color>[
      ColorTheme.primary,
      ColorTheme.primaryTint,
    ],
  );
    static const LinearGradient congratsGradient = LinearGradient(
    stops: [-0.6, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.mirror,
    colors: <Color>[
      Color(0xff575A9D),
      Color(0xff002F5E),
    ],
  );
  static const LinearGradient cardGradient = LinearGradient(
    stops: [-0.431, 1.174],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.mirror,
    colors: <Color>[
      Color(0xff9482FF),
      Color(0xff745FF2),
    ],
  );
  static const LinearGradient buttonGradient = LinearGradient(
    stops: [-0.2898, 1.2332],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    tileMode: TileMode.mirror,
    colors: <Color>[
      Color(0xff239A90),
      Color(0xff8DC449),
    ],
  );
}
