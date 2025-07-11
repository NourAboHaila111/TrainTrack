import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.yellow[700],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.yellow[700],
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.yellow[700]),
      trackColor: MaterialStateProperty.all(Colors.yellow[200]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.white,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121212),
    primaryColor: Colors.yellow[600],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Color(0xFF1F1F1F),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.yellow[600]),
      trackColor: MaterialStateProperty.all(Colors.grey[800]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[600],
        foregroundColor: Colors.black,
      ),
    ),
  );
}
