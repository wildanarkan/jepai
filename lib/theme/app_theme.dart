import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blueAccent,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.lightBlue,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Colors.blue,
      onPrimary: Colors.white, // Untuk teks atau ikon di atas primary color
      onSurface: Colors.black, // Untuk teks atau ikon di atas surface
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blueAccent,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black),
      headlineSmall:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      headlineMedium:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      headlineLarge:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(color: Colors.black),
      labelMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.black),
      titleMedium:
          TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.blueAccent),
      titleLarge: TextStyle(color: Colors.blueAccent),
    ),
    iconTheme: const IconThemeData(
      color: Colors.blueAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.teal),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.blueAccent),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.teal,
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: Colors.tealAccent, // Your accent color
      onPrimary: Colors.white, // Untuk teks atau ikon di atas primary color
      onSurface: Colors.black, // Untuk teks atau ikon di atas surface
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white70),
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white70),
      displayMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      headlineSmall:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headlineMedium:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      headlineLarge:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(color: Colors.white70),
      labelMedium: TextStyle(color: Colors.white70),
      labelSmall: TextStyle(color: Colors.white70),
      titleMedium:
          TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.tealAccent),
      titleLarge: TextStyle(color: Colors.tealAccent),
    ),
    iconTheme: const IconThemeData(
      color: Colors.tealAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.tealAccent),
        foregroundColor: WidgetStateProperty.all(Colors.black),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.tealAccent),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.tealAccent,
    ),
  );
}
