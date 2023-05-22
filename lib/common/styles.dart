import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 255, 70, 85);
const Color secondaryColor = Color.fromARGB(255, 236, 232, 225);
const Color accentColor = Color.fromARGB(255, 15, 25, 35);
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
