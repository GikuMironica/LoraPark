import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/weather_station_controller.dart';
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
double clipSize = 0;

class WeatherStationPage extends StatefulWidget {
  @override
  _WeatherStationPage createState() => _WeatherStationPage();
}

class _WeatherStationPage extends State<WeatherStationPage> {
  @override
  Widget build(BuildContext context) {
    var weatherStationController = Provider.of<WeatherStationController>(
      context,
      listen: false,
    );
    weatherStationController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () async =>
          await weatherStationController.getWeatherStationDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: weatherStationController.scrollController,
        clipSize: clipSize,
        sensorName: 'Weather Station',
        sensorNumber: '01',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: weatherStationController.data == null
                      ? weatherStationController.getWeatherStationDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<WeatherStationController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Temperature',
                                visualization: Image(
                                  image: AssetImage('assets/images/sun.png'),
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
                      const SizedBox(height: verticalOffset),
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<WeatherStationController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Precipitation',
                                visualization: Image(
                                  image: AssetImage('assets/images/cloud.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.rainrate.toString() + ' mm',
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
                          ? Consumer<WeatherStationController>(
                              builder: (_, controller, __) => WeeklyBarChart(
                                temperatureDayData:
                                    controller.getWeeklyReport(),
                                height:
                                    (MediaQuery.of(context).size.width) * 0.7,
                                width: (MediaQuery.of(context).size.width),
                              ),
                            )
                          : LoadingDataPresenter(
                              height: MediaQuery.of(context).size.width * 0.7,
                            ),
                      const SizedBox(height: pageOffset),
                      SensorDescription(
                        text:
                            'This station is a combination of different sensors. The temperature, humidity, air pressure, amount of rain, condensation point, wind speed and direction, solar radiation and the number of particles of various sizes in the air (fine dust) are measured. The weather station is operated independently using a solar module. The measured results are periodically sent via the local LoRaWAN network to our backend, which processes the data for display. This sensor is part of the LoRaPark at Weinhof. Data and visualization are presented on the local display or at lorapark.de. The sensor data are also made freely available to the public on the Ulm data platform under a CC-0 license.',
                        image: AssetImage(
                            'assets/images/weather-station-sensor.jpg'),
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
    var weatherStationController = Provider.of<WeatherStationController>(
      context,
      listen: false,
    );
    setState(() {
      clipSize = (weatherStationController.scrollController.offset / 2);
    });
  }
}
