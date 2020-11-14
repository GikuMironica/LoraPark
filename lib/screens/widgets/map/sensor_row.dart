import 'package:flutter/material.dart';

class BottomSheetSensorRow extends StatelessWidget {
  final String number;
  final String name;

  BottomSheetSensorRow({this.name, this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          children: [
            Text(number),
            Text(name),
          ],
        ),
        Text('View'),
      ],
    );
  }
}
