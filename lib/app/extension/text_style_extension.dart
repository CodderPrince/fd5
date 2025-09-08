import 'package:flutter/material.dart';

/// Extensions on [TextStyle] (non-nullable)
extension TextStyleExtension on TextStyle {
  /// Bold text
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);

  /// Italic text
  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);

  /// Apply a custom color
  TextStyle color(Color color) => copyWith(color: color);

  /// Change font size
  TextStyle size(double fontSize) => copyWith(fontSize: fontSize);

  /// Underline text
  TextStyle underline() => copyWith(decoration: TextDecoration.underline);

  /// Strikethrough text
  TextStyle lineThrough() => copyWith(decoration: TextDecoration.lineThrough);

  /// Add letter spacing
  TextStyle spacing(double space) => copyWith(letterSpacing: space);
}
