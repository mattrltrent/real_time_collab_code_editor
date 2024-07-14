import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    colorScheme: const ColorScheme(
      onSurfaceVariant: Color(0xff1E1E1E), // VS Code dark theme background
      surfaceVariant: Color(0xff252526), // VS Code sidebar background
      brightness: Brightness.dark,
      primary: Color(0xff007ACC), // VS Code blue
      onPrimary: Color(0xffD4D4D4), // Light gray for text
      secondary: Color(0xff0E70C0), // VS Code secondary blue
      onSecondary: Color(0xffFFFFFF), // White for content on secondary color
      tertiary: Color(0xff4EC9B0), // VS Code teal
      surfaceTint: Color(0xff007ACC), // VS Code blue
      error: Color(0xffF48771), // VS Code error red
      onError: Color(0xff1E1E1E), // Dark background for error
      background: Color(0xff1E1E1E), // VS Code dark theme background
      onBackground: Color(0xffD4D4D4), // Light gray for text
      surface: Color(0xff252526), // VS Code sidebar background
      onSurface: Color(0xffD4D4D4), // Light gray for text
      shadow: Color(0xff000000), // Black for shadows
      primaryContainer: Color(0xff3C3C3C), // VS Code panel background
      secondaryContainer: Color(0xff252526), // VS Code sidebar background
      onErrorContainer: Color(0xffF48771), // Same as error color
      onSecondaryContainer: Color(0xff007ACC), // VS Code blue
      onTertiaryContainer: Color(0xffD4D4D4), // Light gray for text
    ),
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    colorScheme: const ColorScheme(
      onSurfaceVariant: Color(0xffF3F3F3), // VS Code light theme background
      surfaceVariant: Color(0xffE7E7E7), // VS Code light sidebar background
      brightness: Brightness.light,
      primary: Color(0xff007ACC), // VS Code blue
      onPrimary: Color(0xff1E1E1E), // Dark text for contrast
      secondary: Color(0xff0E70C0), // VS Code secondary blue
      onSecondary: Color(0xff1E1E1E), // Dark text for contrast
      tertiary: Color(0xff4EC9B0), // VS Code teal
      surfaceTint: Color(0xff007ACC), // VS Code blue
      error: Color(0xffF48771), // VS Code error red
      onError: Color(0xff1E1E1E), // Dark background for error
      background: Color(0xffFFFFFF), // White background
      onBackground: Color(0xff1E1E1E), // Dark text for contrast
      surface: Color(0xffE7E7E7), // VS Code light sidebar background
      onSurface: Color(0xff1E1E1E), // Dark text for contrast
      shadow: Color(0xff000000), // Black for shadows
      primaryContainer: Color(0xffF3F3F3), // VS Code light theme background
      secondaryContainer: Color(0xffE7E7E7), // VS Code light sidebar background
      onErrorContainer: Color(0xffF48771), // Same as error color
      onSecondaryContainer: Color(0xff007ACC), // VS Code blue
      onTertiaryContainer: Color(0xff1E1E1E), // Dark text for contrast
    ),
  );
}
