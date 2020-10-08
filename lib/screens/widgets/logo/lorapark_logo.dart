import 'package:flutter/material.dart';
import 'package:lorapark_app/config/consts.dart' show LORAPARK;

class LoraParkLogo extends StatelessWidget {
  final bool black;
  final double size;

  LoraParkLogo({this.black = false, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      LORAPARK,
      style: TextStyle(
        color: black ? Colors.black : Colors.white,
        fontFamily: 'Roboto Condensed',
        fontWeight: FontWeight.w700,
        fontSize: size,
      ),
    );
  }
}
