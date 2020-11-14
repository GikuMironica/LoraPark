import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/ground_humidity_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
double clipSize = 0;

class GroundHumidityPage extends StatefulWidget {
  @override
  _GroundHumidityPage createState() => _GroundHumidityPage();
}

class _GroundHumidityPage extends State<GroundHumidityPage> {
  @override
  Widget build(BuildContext context) {
    var groundHumidityController = Provider.of<GrouundHumidityController>(
      context,
      listen: false,
    );
    groundHumidityController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async =>
          await groundHumidityController.getActualGroundHumidityData(),
      child: SingleSensorViewTemplate(
        scrollController: groundHumidityController.scrollController,
        clipSize: clipSize,
        sensorName: 'Ground Humidity',
        sensorNumber: '09',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: groundHumidityController.data == null
                      ? groundHumidityController.getActualGroundHumidityData()
                      : null,
                  builder: (context, snapshot) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.connectionState == ConnectionState.done ||
                                snapshot.connectionState == ConnectionState.none
                            ? Consumer<GrouundHumidityController>(
                                builder: (_, controller, __) => DataPresenter(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  title: 'Volumetric Water Content',
                                  visualization: Image(
                                    image: AssetImage('assets/images/vwc.png'),
                                    height: 200,
                                    width: 200,
                                  ),
                                  data: Text(
                                    controller.vwc.toString() + ' %',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            : LoadingDataPresenter(),
                        const SizedBox(height: verticalOffset),
                        snapshot.connectionState == ConnectionState.done ||
                                snapshot.connectionState == ConnectionState.none
                            ? Consumer<GrouundHumidityController>(
                                builder: (_, controller, __) => DataPresenter(
                                  width: MediaQuery.of(context).size.width,
                                  height: (MediaQuery.of(context).size.width) *
                                      0.30,
                                  title: 'Ground Temperature',
                                  visualization: Image(
                                    image: AssetImage('assets/images/temp.png'),
                                    height: 200,
                                    width: 200,
                                  ),
                                  data: Text(
                                    controller.temperature.toString() + ' °C',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            : LoadingDataPresenter(),
                        const SizedBox(height: pageOffset),
                        SensorDescription(
                          text:
                              'This sensor is located underground at a depth of approx. 50 cm. There, the sensor measures the electrical conductivity, the volume water content, the temperature and the degree of water saturation in the soil. The sensor is connected to the transmitter module located above the ground surface via a cable. This way, targeted and economical irrigation can take place. The measurement data are periodically sent to our backend via the local LoRaWAN network. This data is processed there for display purposes.',
                          image: AssetImage(
                              'assets/images/ground-humidity-sensor.jpg'),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    var groundHumidityController = Provider.of<GrouundHumidityController>(
      context,
      listen: false,
    );
    setState(() {
      clipSize = (groundHumidityController.scrollController.offset / 2);
    });
  }
}
