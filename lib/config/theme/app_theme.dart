import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true
    ),
    colorSchemeSeed: Color.fromARGB(255, 28, 16, 243)
  );
}