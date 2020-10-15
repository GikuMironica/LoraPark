import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/clipper/clipper.dart';
import 'package:lorapark_app/screens/widgets/sensor_view_header/sensor_view_header.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class SingleSensorViewTemplate extends StatelessWidget {
  ScrollController scrollController;
  Widget sliverlist;
  final double padding = 24.0;
  final double horizontalOffset = 20;
  final double verticalOffset = 24;
  final double pageOffset = 20;
  double clipSize;
  var sensorController;
  String sensorName;
  String sensorNumber;

  SingleSensorViewTemplate(
      {this.scrollController,
      this.sliverlist,
      this.sensorController,
      this.clipSize,
      this.sensorName,
      this.sensorNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Clipper(),
            child: Container(
              padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
              height:
                  (MediaQuery.of(context).size.height / 2 - clipSize * 0.5) <=
                          100
                      ? 100
                      : MediaQuery.of(context).size.height / 2 - clipSize * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: LoraParkTheme.themeData.primaryColor,
              ),
            ),
          ),
          CustomScrollView(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            slivers: [SensorViewHeader(sensorNumber: sensorNumber, sensorName: sensorName,), this.sliverlist],
          ),
        ],
      ),
    );
  }
}
