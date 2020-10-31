import 'package:flutter/material.dart';
import 'package:darq/darq.dart';

import 'package:lorapark_app/config/sensor_list.dart' show sensorList;
import 'package:lorapark_app/data/models/sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_card.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class SensorListPage extends StatelessWidget {
  final List<Sensor> sensors =
      sensorList.distinct((sensor) => sensor.type).toList();

  SensorListPage() {
    sensors.sort((s1, s2) => s1.number.compareTo(s2.number));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            backgroundColor: LoraParkTheme.themeData.primaryColor,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Available Sensors',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: sensors.length,
                  itemBuilder: (_, index) => SensorCard(sensor: sensors[index]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
