import 'package:flutter/material.dart';
import 'package:lorapark_app/config/router/application.dart';
import 'package:lorapark_app/config/router/routes.dart';
import 'package:lorapark_app/controller/main_page_controller/main_page_controller.dart';
import 'package:lorapark_app/data/models/sensor.dart';
import 'package:provider/provider.dart';

class BottomSheetSensorRow extends StatelessWidget {
  final Sensor sensor;

  BottomSheetSensorRow({this.sensor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16.0,
          children: [
            CircleAvatar(
              minRadius: 16,
              maxRadius: 16,
              backgroundColor: Colors.grey,
              backgroundImage: sensor.image,
            ),
            Text(sensor.name),
          ],
        ),
        GestureDetector(
          onTap: () => context.read<MainPageController>().changePageWithRoute(Routes.sensorPage + sensor.number),
          child: Chip(
            elevation: 1,
            backgroundColor: Colors.blue,
            label: Text('View', style: TextStyle(fontSize: 12, color: Colors.white),),
          ),
        )
      ],
    );
  }
}
