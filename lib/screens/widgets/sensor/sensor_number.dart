import 'package:flutter/material.dart';
import 'package:lorapark_app/config/consts.dart';

class SensorNumber extends StatelessWidget {
  final String number;
  final bool showUrl;
  final bool dark;
  final double size;

  SensorNumber(
      {@required this.number,
      this.showUrl = true,
      this.dark = false,
      this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '#$number',
          style: TextStyle(
              color: dark ? Colors.black : Colors.white,
              fontSize: size * 2,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: size * 2,
          height: 7,
          child: Container(
            color: dark ? Colors.black : Colors.white,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          showUrl ? LORAPARK_URL : LORAPARK,
          style: TextStyle(
            fontSize: size,
            color: dark ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
