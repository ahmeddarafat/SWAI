import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

class AppTheme {
  static ThemeData getLight() {
    return ThemeData(
      /// color theme
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.lightBlue.withOpacity(0.2),
      ),

      /// AppBar theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
      ),
    );
  }
}
