import 'package:flutter/material.dart';
import 'package:lorapark_app/data/models/sensor.dart';
import 'package:lorapark_app/screens/widgets/map/sensor_row.dart';

class MapBottomSheet extends StatelessWidget {
  final List<Sensor> sensorList;

  MapBottomSheet({this.sensorList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.15))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                height: 3,
                width: MediaQuery.of(context).size.width * 0.2,
                child: DecoratedBox(
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.3)),
                ),
              ),
            ),
          ),
          Text(
            'Sensors (${sensorList.length})',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
              separatorBuilder: (_, idx) => SizedBox(height: MediaQuery.of(_).size.height * 0.02),
              itemCount: sensorList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => BottomSheetSensorRow(sensor: sensorList[index],),
            ),
          ),
        ],
      ),
    );
  }
}
