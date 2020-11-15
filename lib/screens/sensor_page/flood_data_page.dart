import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/flood_data_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class FloodDataPage extends StatefulWidget {
  @override
  _FloodDataPageState createState() => _FloodDataPageState();
}

class _FloodDataPageState extends State<FloodDataPage> {
  FloodDataController _floodDataController;
  double _clipSize = 0;

  @override
  void initState() {
    _clipSize = 0;
    _floodDataController = Provider.of<FloodDataController>(
      context,
      listen: false,
    );
    _floodDataController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _floodDataController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async => await _floodDataController.getFloodDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: _floodDataController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: _floodDataController.data == null
                      ? _floodDataController.getFloodDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<FloodDataController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Current Distance',
                                visualization: Image(
                                  width: 60,
                                  height: 60,
                                  image:
                                      AssetImage('assets/images/sea-level.png'),
                                ),
                                data: Text(
                                  controller.currentDistance.toString() + ' cm',
                                  style: const TextStyle(
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
                      )
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
      _clipSize = (_floodDataController.scrollController.offset / 2);
    });
  }
}
