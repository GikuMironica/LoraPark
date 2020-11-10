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
                        image: AssetImage('assets/images/flood.jpg'),
                        text:
                            'Der schöne Rad- und Fußweg entlang der Donau erfreut sich großer Beliebtheit. Unter den Brücken ist der Weg nur wenige Zentimeter über dem Normalpegelstand des Flusses. Dieser Zustand kann sich nach Regen innerhalb kurzer Zeit ändern, so dass Hochwasser schnell zum Problem wird. Mit unserer Lösung wird das Hochwasser unmittelbar erkannt, über das LoRaWAN-Netzwerk übertragen und evtl. weitere Maßnahmen wie eine Sperrung eingeleitet. Der Sensor hat batteriebetrieben eine Laufzeit von ca. 4 Jahren.',
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
