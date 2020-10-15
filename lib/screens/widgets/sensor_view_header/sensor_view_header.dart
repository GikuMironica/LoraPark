import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_number.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';


class SensorViewHeader extends StatelessWidget {
  final String sensorName;
  final String sensorNumber;

  const SensorViewHeader({
    @required this.sensorName,
    @required this.sensorNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: LoraParkTheme.themeData.primaryColor,
      pinned: true,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 4,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: FittedBox(
          alignment: Alignment.bottomLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            sensorName,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        background: Padding(
          padding: const EdgeInsets.all(24),
          child: SensorNumber(
            number: sensorNumber,
            showUrl: false,
            size: 12.0,
            dark: false,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        alignment: Alignment.center,
        onPressed: () {
          /* ... */ //#TODO
        },
      ),
    );
  }
}
