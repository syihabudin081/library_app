import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 130, 148, 196);
const Color secondaryColor = Color.fromARGB(255, 218, 221, 239);
const Color accentColor1 = Color.fromARGB(255, 254, 161, 161);
const Color accentColor2 = Color.fromARGB(255, 255, 234, 210);
const Color accentColor3 = Color.fromARGB(255, 236, 239, 247);
const Color accentColor4 = Color.fromARGB(255, 96, 96, 122);
const Color successColor = Color.fromARGB(255, 95, 200, 150);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[0.05];
  final Map<int, Color> swatch = {
    50: color.withOpacity(strengths[0]),
    100: color.withOpacity(strengths[0]),
    200: color.withOpacity(strengths[0]),
    300: color.withOpacity(strengths[0]),
    400: color.withOpacity(strengths[0]),
    500: color.withOpacity(strengths[0]),
    600: color.withOpacity(strengths[0]),
    700: color.withOpacity(strengths[0]),
    800: color.withOpacity(strengths[0]),
    900: color.withOpacity(strengths[0]),
  };
  return MaterialColor(color.value, swatch);
}
