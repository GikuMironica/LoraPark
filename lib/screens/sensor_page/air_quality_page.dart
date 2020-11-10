import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/air_quality_controller.dart';
import 'package:lorapark_app/screens/widgets/charts/air_quality_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
double clipSize = 0;

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPage createState() => _AirQualityPage();
}

class _AirQualityPage extends State<AirQualityPage> {
  @override
  Widget build(BuildContext context) {
    var airQualityController = Provider.of<AirQualityController>(
      context,
      listen: false,
    );
    airQualityController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async =>
          await airQualityController.getAirQualityDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: airQualityController.scrollController,
        clipSize: clipSize,
        sensorName: 'Air Quality',
        sensorNumber: '02',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: airQualityController.data == null
                      ? airQualityController.getAirQualityDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<AirQualityController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).size.width) * 0.30,
                                title: 'NO2 Concentration',
                                visualization: Image(
                                  image:
                                      AssetImage('assets/images/polution.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.no2Concentration.toString() +
                                      ' ppm',
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
                          ? Consumer<AirQualityController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).size.width) * 0.30,
                                title: 'NO Concentration',
                                visualization: Image(
                                  image:
                                      AssetImage('assets/images/polution.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.noConcentration.toString() +
                                      ' ppm',
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
                          ? Consumer<AirQualityController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).size.width) * 0.30,
                                title: 'CO Concentration',
                                visualization: Image(
                                  image:
                                      AssetImage('assets/images/polution.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.coConcentration.toString() +
                                      ' ppm',
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
                          ? WeeklyAirQualityBarChart(
                              airQualityDayData:
                                  airQualityController.getWeeklyReport(),
                              height: (MediaQuery.of(context).size.width) * 0.7,
                              width: (MediaQuery.of(context).size.width),
                            )
                          : LoadingDataPresenter(),
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
    var airQualityController = Provider.of<AirQualityController>(
      context,
      listen: false,
    );
    setState(() {
      clipSize = (airQualityController.scrollController.offset / 2);
    });
  }
}
