import 'package:flutter/material.dart';

class LPNavBarItem {
  /// The path to the svg in the assets/icons/ folder
  final String iconName;

  /// The text that is displayed below the icon.
  final String title;

  LPNavBarItem({
    @required this.iconName,
    @required this.title,
  });
}
