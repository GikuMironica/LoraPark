import 'package:flutter/material.dart';
import 'package:lorapark_app/config/consts.dart';
import 'package:lorapark_app/screens/widgets/logo/lorapark_logo.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_number.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            BG_TOP_GRADIENT,
            BG_BOTTOM_GRADIENT,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoraParkLogo(size: 30),
            SizedBox(height: 20,),
            SensorNumber(number: '19',),
          ],
        ),
      ),
    );
  }
}
