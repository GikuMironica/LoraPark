import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/controller/sensor_controller/flood_data_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class FloodDataPage extends StatefulWidget {
  @override
  _FloodDataPageState createState() => _FloodDataPageState();
}

class _FloodDataPageState extends State<FloodDataPage> {
  double clipSize = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var floodDataController = Provider.of<FloodDataController>(
      context,
      listen: false,
    );
    floodDataController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async => await floodDataController.getFloodDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: floodDataController.scrollController,
        clipSize: clipSize,
        sensorName: 'Flood Data',
        sensorNumber: '08',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: floodDataController.data == null
                      ? floodDataController.getFloodDataByTime(7)
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
                        image:
                            AssetImage('assets/images/flood-data-sensor.jpg'),
                        text:
                            'The beautiful bike and foot paths along the Danube are very popular. Under the bridges the path is only a few centimeters above the normal level of the river. This condition can change within a short time after rain, so that flooding quickly becomes a problem. With our solution, the flood is detected immediately, transmitted via the LoRaWAN network and further measures such as a blockade can be initiated. Battery operated, the sensor has a running time of approx. 4 years.',
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
    var floodDataController = Provider.of<FloodDataController>(
      context,
      listen: false,
    );

    setState(() {
      clipSize = (floodDataController.scrollController.offset / 2);
    });
  }
}
