import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/structure_damage_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class StructureDamagePage extends StatefulWidget {
  @override
  _StructureDamagePageState createState() => _StructureDamagePageState();
}

class _StructureDamagePageState extends State<StructureDamagePage> {
  double clipSize = 0;

  @override
  Widget build(BuildContext context) {
    var structureDamageController = Provider.of<StructureDamageController>(
      context,
      listen: false,
    );
    structureDamageController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async =>
          await structureDamageController.getStructureDamageDataByTime(10),
      child: SingleSensorViewTemplate(
        scrollController: structureDamageController.scrollController,
        clipSize: clipSize,
        sensorName: 'Structure Damage',
        sensorNumber: '14',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: structureDamageController.data == null
                      ? structureDamageController
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
                        image: AssetImage('assets/images/structuredamage.jpg'),
                        text:
                            'Veränderungen von Rissen werden am Ulmer Münster historisch mit Millimeterpapier kenntlich gemacht. Heute übernimmt ein Lasersensor mit Messgenauigkeiten im Mikrometerbereich diese Überwachung und sendet die Messdaten in regelmäßigen Abständen via LoRaWAN in unser Backend. Ein mathematisches Modell analysiert die Rohdaten und korrigiert Rauschen und Schwankungen bei dieser hochpräzisen Messung.',
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
    var structureDamageController = Provider.of<StructureDamageController>(
      context,
      listen: false,
    );

    setState(() {
      clipSize = (structureDamageController.scrollController.offset / 2);
    });
  }
}
