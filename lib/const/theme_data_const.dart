import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? const Color(0xFF00001a)
          : const Color.fromARGB(223, 38, 63, 67),
      // primaryColor: Colors.red,
      cardColor:
          isDarkTheme ? const Color(0xFF0a0d2c) : const Color(0xFFE8FDFD),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.highContrastLight()),
      
      dividerColor: isDarkTheme
          ? const Color(0xFF00001a)
          : const Color.fromARGB(223, 38, 63, 67),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:  isDarkTheme
              ? const Color(0xFF00001a)
              : const Color.fromARGB(223, 38, 63, 67),
              ),
       appBarTheme: AppBarTheme(
          backgroundColor:  isDarkTheme
              ? const Color(0xFF00001a)
              : const Color.fromARGB(223, 38, 63, 67),
              ),
      iconTheme: IconThemeData(
          color:  isDarkTheme
              ? const Color.fromARGB(223, 168, 53, 53)
              : const Color(0xFF00001a)
      )  ,
      drawerTheme: DrawerThemeData(
        backgroundColor: isDarkTheme
        ? const Color(0xFF00001a)
        : const Color.fromARGB(223, 38, 63, 67),),
        cardTheme: CardTheme(
          color: isDarkTheme
        ? const Color(0xFF00001a)
        : const Color.fromARGB(223, 38, 63, 67),
        )
     


    );
  }
}
