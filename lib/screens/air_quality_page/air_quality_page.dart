import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/air_quality_controller.dart';
import 'package:lorapark_app/controller/sensor_controller/weather_station_controller.dart';
import 'package:lorapark_app/screens/widgets/charts/air_quality_chart.dart';
import 'package:lorapark_app/screens/widgets/charts/weather_station_weekly_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
var airQualityController;
double clipSize = 0;
bool isInit = true;
bool isLoading = true;

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPage createState() => _AirQualityPage();
}

class _AirQualityPage extends State<AirQualityPage> {
  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;

      airQualityController = Provider.of<AirQualityController>(
        context,
        listen: false,
      );

      airQualityController.getAirQualityDataByTime(7).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    airQualityController = Provider.of<AirQualityController>(
      context,
      listen: false,
    );
    airQualityController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => airQualityController.getAirQualityDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: airQualityController.scrollController,
        clipSize: clipSize,
        sensorName: "Air Quality",
        sensorNumber: "xx",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.height - 250) / 4,
                            title: "NO2 Concentration",
                            visualization: Image(
                              image: AssetImage("assets/images/polution.png"),
                              height: 200,
                              width: 200,
                            ),
                            data: airQualityController.data == null
                                ? Text(
                                    '0 ppm',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    airQualityController.no2Concentration
                                            .toString() +
                                        " " +
                                        "ppm",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                    SizedBox(height: verticalOffset),
                    isLoading
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.height - 250) / 4,
                            title: "NO Concentration",
                            visualization: Image(
                              image: AssetImage("assets/images/polution.png"),
                              height: 200,
                              width: 200,
                            ),
                            data: airQualityController.data == null
                                ? Text(
                                    '0 ppm',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    airQualityController.noConcentration
                                            .toString() +
                                        " " +
                                        "ppm",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                    SizedBox(height: verticalOffset),
                    isLoading
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height:
                                (MediaQuery.of(context).size.height - 250) / 4,
                            title: "CO Concentration",
                            visualization: Image(
                              image: AssetImage("assets/images/polution.png"),
                              height: 200,
                              width: 200,
                            ),
                            data: airQualityController.data == null
                                ? Text(
                                    '0 ppm',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    airQualityController.coConcentration
                                            .toString() +
                                        " " +
                                        "ppm",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                          ),
                    SizedBox(height: verticalOffset),
                    isLoading
                        ? LoadingDataPresenter()
                        : WeeklyAirQualityBarChart(
                            airQualityDayData:
                                airQualityController.getWeeklyReport(),
                            height:
                                (MediaQuery.of(context).size.height - 250) / 3,
                            width: (MediaQuery.of(context).size.width),
                          )
                  ],
                ),
              ),
              SizedBox(height: pageOffset),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = (airQualityController.scrollController.offset / 2);
    });
  }
}
