import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/raised_garden_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double verticalOffset = 24;
const double pageOffset = 20;
double clipSize = 0;

class RaisedGardenPage extends StatefulWidget {
  @override
  _RaisedGardenPage createState() => _RaisedGardenPage();
}

class _RaisedGardenPage extends State<RaisedGardenPage> {
  @override
  Widget build(BuildContext context) {
    var raisedGardenController = Provider.of<RaisedGardenController>(
      context,
      listen: false,
    );
    raisedGardenController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async =>
          await raisedGardenController.getRaisedGardennData(),
      child: SingleSensorViewTemplate(
        scrollController: raisedGardenController.scrollController,
        clipSize: clipSize,
        sensorName: 'Raised Garden',
        sensorNumber: '12',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: raisedGardenController.data == null
                      ? raisedGardenController.getRaisedGardennData()
                      : null,
                  builder: (context, snapshot) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot.connectionState == ConnectionState.done ||
                                snapshot.connectionState == ConnectionState.none
                            ? Consumer<RaisedGardenController>(
                                builder: (_, controller, __) => DataPresenter(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  title: 'Water tank state',
                                  visualization: Image(
                                    image: AssetImage(
                                        'assets/images/water_level.png'),
                                    height: 200,
                                    width: 200,
                                  ),
                                  data: Text(
                                    (controller.watertankEmpty
                                        ? 'Empty'
                                        : 'Full'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : LoadingDataPresenter(),
                        const SizedBox(height: verticalOffset),
                        snapshot.connectionState == ConnectionState.done ||
                                snapshot.connectionState == ConnectionState.none
                            ? Consumer<RaisedGardenController>(
                                builder: (_, controller, __) => DataPresenter(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                  title: 'Ground Humidity',
                                  visualization: Image(
                                    image: AssetImage('assets/images/vwc.png'),
                                    height: 200,
                                    width: 200,
                                  ),
                                  data: Text(
                                    controller.humidity.toString() + ' %',
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
                              'The self-sufficient raised garden irrigates itself independently and automatically via an integrated water tank, depending on the humidity of the soil in the flowerpot. The measurement of the soil moisture is regulated by tensiometers, which - like plants themselves - determine the water content in the soil via the suction tension. If the humidity level is too low, watering is triggered. To monitor the flowerpot, especially the water level in the tank and the soil moisture, sensor data are regularly sent via LoRaWAN, which, for example, can facilitate joint urban gardening projects.',
                          image: AssetImage(
                              'assets/images/raised-garden-sensor.jpg'),
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
    var raisedGardenController = Provider.of<RaisedGardenController>(
      context,
      listen: false,
    );
    setState(() {
      clipSize = (raisedGardenController.scrollController.offset / 2);
    });
  }
}
