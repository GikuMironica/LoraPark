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
  double clipSize = 0;

  @override
  Widget build(BuildContext context) {
    var energyDataController = Provider.of<EnergyDataController>(
      context,
      listen: false,
    );
    energyDataController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => energyDataController.getEnergyDataByTime(6),
      child: SingleSensorViewTemplate(
        scrollController: energyDataController.scrollController,
        clipSize: clipSize,
        sensorName: 'Energy Data',
        sensorNumber: '15',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Consumer<EnergyDataController>(
                  builder: (context, controller, _) => Column(
                    children: [
                      energyDataController.data == null
                          ? LoadingDataPresenter()
                          : DataPresenter(
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
                      const SizedBox(height: 24),
                      energyDataController.data == null
                          ? LoadingDataPresenter()
                          : DataPresenter(
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
                                controller.currentReturnTemperature.toString() +
                                    ' °C',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                ),
                              ),
                            ),
                      const SizedBox(height: 24),
                      energyDataController.data == null
                          ? LoadingDataPresenter(
                              height: MediaQuery.of(context).size.width * 0.95,
                            )
                          : DataPresenter(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.95,
                              title: 'Weekly Report',
                              data: EnergyDataChart(),
                            ),
                      const SizedBox(height: 24),
                      SensorDescription(
                        image: AssetImage('assets/images/energy.jpg'),
                        text:
                            'Das Donaubad, das größte Erlebnisbad der Region, mit seinem Strömungskanal, Entspannungsbecken oder dem 36 Grad warmen Thermalwasserbecken setzt ebenfalls auf LoRaWAN und IoT Anwendungen. Neben der Wassertemperatur wird auch die Wärmemenge und der CO2-Wert der Raumluft überwacht.',
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
    var energyDataController = Provider.of<EnergyDataController>(
      context,
      listen: false,
    );

    setState(() {
      clipSize = (energyDataController.scrollController.offset / 2);
    });
  }
}
