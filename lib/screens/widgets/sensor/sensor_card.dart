import 'package:flutter/material.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

import '../../../data/models/sensor.dart';

class SensorCard extends StatelessWidget {
  final Sensor sensor;

  SensorCard({@required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [LoraParkTheme.boxShadow],
            color: Colors.white,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: sensor.image,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          Text(
                            'Location',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sensor.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Placeholder for a long description on 3 lines and bla bla bla bla bla bla bla bla lol kek looooool',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#' + sensor.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
