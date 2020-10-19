import 'package:flutter/material.dart';

class LoraParkTheme {

  static Radius bottomBarRadius = Radius.circular(20);
  static Color bottomBarColor = Colors.white;
  static Color bottomBarSelectedItemColor = Colors.pink;
  static Color bottomBarSelectedItemTitle = Colors.black;


  static ThemeData themeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: Color(0xFF121212),
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.tealAccent,
    fontFamily: 'Hind',
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static BoxShadow boxShadow = BoxShadow(
    color: Color(0xff657582).withOpacity(0.17),
    blurRadius: 20,
    spreadRadius: 2,
    offset: Offset(5, 5),
  );
}
