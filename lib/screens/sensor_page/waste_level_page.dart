import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/charts/waste_level_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

import 'package:lorapark_app/controller/sensor_controller/waste_level_controller.dart';

class WasteLevelPage extends StatefulWidget {
  @override
  _WasteLevelPageState createState() => _WasteLevelPageState();
}

class _WasteLevelPageState extends State<WasteLevelPage> {
  WasteLevelController _wasteLevelController;
  double _clipSize = 0;

  @override
  void initState() {
    _clipSize = 0;
    _wasteLevelController = Provider.of<WasteLevelController>(
      context,
      listen: false,
    );
    _wasteLevelController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _wasteLevelController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          await _wasteLevelController.getWasteLevelDataByTime(6),
      child: SingleSensorViewTemplate(
        scrollController: _wasteLevelController.scrollController,
        clipSize: _clipSize,
        sensorName: 'Waste Level',
        sensorNumber: '04',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: _wasteLevelController.data == null
                      ? _wasteLevelController.getWasteLevelDataByTime(6)
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<WasteLevelController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Current State',
                                visualization: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentFillRatio <=
                                            WasteLevelController
                                                .FILL_RATIO_THRESHOLD
                                        ? Color(0xff91b54b)
                                        : Color(0xffd35668),
                                  ),
                                  width: 15,
                                  height: 15,
                                ),
                                data: Text(
                                  controller.currentFillRatio
                                          .toStringAsFixed(0) +
                                      '% full',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      SizedBox(
                        height: 24,
                      ),
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<WasteLevelController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.5,
                                title: 'Last 7 days',
                                data: WasteLevelChart(
                                  sectionData: [
                                    WasteLevelChartSectionData(
                                      controller.getPercentEmpty(),
                                      controller
                                              .getPercentEmpty()
                                              .toStringAsFixed(0) +
                                          '%',
                                      Color(0xff91b54b),
                                    ),
                                    WasteLevelChartSectionData(
                                      controller.getPercentFull(),
                                      controller
                                              .getPercentFull()
                                              .toStringAsFixed(0) +
                                          '%',
                                      Color(0xffd35668),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : LoadingDataPresenter(
                              height: MediaQuery.of(context).size.width * 0.5,
                            ),
                      SizedBox(height: 20),
                      SensorDescription(
                        text:
                            'With this sensor, the filling level of a container can be determined using an ultrasonic distance measurement. If the container is full, a collection can be triggered automatically. This not only offers the advantage that there is no littering in the city, but also unnecessary emptying can be saved and the route can be adapted to the actual needs during collection.',
                        image: AssetImage(
                          'assets/images/waste-level-sensor.jpg',
                        ),
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
      _clipSize = (_wasteLevelController.scrollController.offset / 2);
    });
  }
}
