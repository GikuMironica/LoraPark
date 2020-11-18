import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/rat_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;

class RatPage extends StatefulWidget {
  @override
  _RatPage createState() => _RatPage();
}

class _RatPage extends State<RatPage> {
  RatController _ratController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _ratController = Provider.of<RatController>(
      context,
      listen: false,
    );
    _ratController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _ratController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async => await _ratController.fetchData(),
      child: SingleSensorViewTemplate(
        scrollController: _ratController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: _ratController.data == null
                      ? _ratController.fetchData()
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<RatController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Number of rat visits',
                                visualization: Image(
                                  image: AssetImage('assets/images/rat.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller
                                          .ratVisits[
                                              controller.ratVisits.length - 1]
                                          .y
                                          .toString() +
                                      ' rat visits',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: verticalOffset),
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
      _clipSize = (_ratController.scrollController.offset / 2);
    });
  }
}
