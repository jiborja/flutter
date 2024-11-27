import 'package:flutter/material.dart';
import 'package:presentation/shared/borders.dart';
import 'package:presentation/shared/theme.dart';

class MovieDecorations {
  static InputDecoration buildInputDecoration(String title, IconData icon) {
    return InputDecoration(
      prefixIcon: SizedBox(
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(icon), const VerticalDivider(width: 2)],
        ),
      ),
      labelText: title,
      border: textFieldBorderDecoration,
      focusedBorder: textFieldBorderDecoration,
      enabledBorder: textFieldBorderDecoration,
      labelStyle:
          const TextStyle(color: MovieColors.primaryColor, fontSize: 15),
    );
  }
}
