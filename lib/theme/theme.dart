import 'package:flutter/material.dart';
import 'custom_theme/appbar_theme.dart';
import 'custom_theme/elevated_buttom_theme.dart';
import 'custom_theme/outline_button.dart';
import 'custom_theme/text_feild_theme.dart';
import 'custom_theme/text_theme.dart';

class MyAppTheme{
  MyAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyTextTheme.lightTextTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    outlinedButtonTheme: MyOutLineButtonTheme.lightOutLineButtonTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData dartTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyTextTheme.darkTextTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    outlinedButtonTheme: MyOutLineButtonTheme.darkOutLineButtonTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
  );
}