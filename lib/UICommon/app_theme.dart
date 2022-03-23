import 'package:flutter/material.dart';
import 'package:mafia_helper/UICommon/app_color.dart';

// import 'colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    //1
    return ThemeData(
        colorScheme: const ColorScheme.dark(
            primary: Colors.orange,
            secondary: Colors.white,
            background: AppColor.primary),
        toggleableActiveColor: Colors.orange,
        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 16)),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                textStyle: MaterialStateProperty.resolveWith((state) {
                  return const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold);
                }))));
  }
}
