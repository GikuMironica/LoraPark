import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/energy_data_controller.dart';
import 'package:lorapark_app/screens/widgets/charts/energy_data_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class EnergyDataPage extends StatefulWidget {
  @override
  _EnergyDataPageState createState() => _EnergyDataPageState();
}

class _EnergyDataPageState extends State<EnergyDataPage> {
  EnergyDataController _energyDataController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _energyDataController = Provider.of<EnergyDataController>(
      context,
      listen: false,
    );
    _energyDataController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _energyDataController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await _energyDataController.getEnergyDataByTime(6),
      child: SingleSensorViewTemplate(
        scrollController: _energyDataController.scrollController,
        clipSize: _clipSize,
        sensorName: 'Energy Data',
        sensorNumber: '15',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: _energyDataController.data == null
                      ? _energyDataController.getEnergyDataByTime(6)
                      : null,
                  builder: (context, snapshot) => Column(
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<EnergyDataController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Temperature of Incoming Water',
                                visualization: Image(
                                  image: AssetImage(
                                    'assets/images/water-temperature.png',
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                                data: Text(
                                  controller.currentFlowTemperature.toString() +
                                      ' °C',
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
                          ? Consumer<EnergyDataController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Temperature of Outgoing Water',
                                visualization: Image(
                                  image: AssetImage(
                                    'assets/images/water-temperature.png',
                                  ),
                                  width: 60,
                                  height: 60,
                                ),
                                data: Text(
                                  controller.currentReturnTemperature
                                          .toString() +
                                      ' °C',
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
                          ? Consumer<EnergyDataController>(
                              builder: (_, __, ___) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.95,
                                title: 'Weekly Report',
                                data: EnergyDataChart(),
                              ),
                            )
                          : LoadingDataPresenter(
                              height: MediaQuery.of(context).size.width * 0.95,
                            ),
                      const SizedBox(height: 24),
                      SensorDescription(
                        image:
                            AssetImage('assets/images/energy-data-sensor.jpg'),
                        text:
                            'The Donaubad, the largest adventure pool in the region, with its flow channel, relaxation pool or the 36 degree warm thermal water pool also relies on LoRaWAN and IoT applications. In addition to the water temperature, the amount of heat and the CO2 value of the room air are also monitored.',
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
      _clipSize = (_energyDataController.scrollController.offset / 2);
    });
  }
}
