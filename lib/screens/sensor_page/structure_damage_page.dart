import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/structure_damage_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class StructureDamagePage extends StatefulWidget {
  @override
  _StructureDamagePageState createState() => _StructureDamagePageState();
}

class _StructureDamagePageState extends State<StructureDamagePage> {
  StructureDamageController _structureDamageController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _structureDamageController = Provider.of<StructureDamageController>(
      context,
      listen: false,
    );
    _structureDamageController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _structureDamageController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async =>
          await _structureDamageController.getStructureDamageDataByTime(10),
      child: SingleSensorViewTemplate(
        scrollController: _structureDamageController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: _structureDamageController.data == null
                      ? _structureDamageController
                          .getStructureDamageDataByTime(10)
                      : null,
                  builder: (context, snapshot) => Column(
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<StructureDamageController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Current Distance',
                                visualization: Image(
                                  image: AssetImage(
                                      'assets/images/broken-house.png'),
                                  width: 60,
                                  height: 60,
                                ),
                                data: Text(
                                  controller.currentDistance.toString() + ' mm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: 24),
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<StructureDamageController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Change in the last 10 days',
                                visualization: Image(
                                  image: AssetImage('assets/images/resize.png'),
                                  width: 60,
                                  height: 60,
                                ),
                                data: Text(
                                  controller
                                          .getDistanceDifferenceInLastDays(10)
                                          .toStringAsFixed(1) +
                                      ' mm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: 24),
                      SensorDescription(
                        text: sensor.description,
                        image: sensor.image,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      _clipSize = (_structureDamageController.scrollController.offset / 2);
    });
  }
}
