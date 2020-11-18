import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/raised_garden_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double verticalOffset = 24;
const double pageOffset = 20;

class RaisedGardenPage extends StatefulWidget {
  @override
  _RaisedGardenPage createState() => _RaisedGardenPage();
}

class _RaisedGardenPage extends State<RaisedGardenPage> {
  RaisedGardenController _raisedGardenController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _raisedGardenController = Provider.of<RaisedGardenController>(
      context,
      listen: false,
    );
    _raisedGardenController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _raisedGardenController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async =>
          await _raisedGardenController.getRaisedGardennData(),
      child: SingleSensorViewTemplate(
        scrollController: _raisedGardenController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: _raisedGardenController.data == null
                      ? _raisedGardenController.getRaisedGardennData()
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
                          text: sensor.description,
                          image: sensor.image,
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
    setState(() {
      _clipSize = (_raisedGardenController.scrollController.offset / 2);
    });
  }
}
