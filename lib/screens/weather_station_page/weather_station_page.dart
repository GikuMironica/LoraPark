import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_number.dart';
import 'package:lorapark_app/controllers/weather_station_controller.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
var weatherStationController;
double clipSize = 0;

class WeatherStationPage extends StatefulWidget {
  @override
  _WeatherStationPage createState() => _WeatherStationPage();
}

class _WeatherStationPage extends State<WeatherStationPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    weatherStationController =
        Provider.of<WeatherStationController>(context);
    weatherStationController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => weatherStationController.getWeatherStationDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: weatherStationController.scrollController,
        clipSize: clipSize,
        sensorController: weatherStationController,
        sensorName: "Weather Station",
        sensorNumber: "01",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataPresenter(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.height - 250) / 4,
                      title: "Temperature",
                      image: const AssetImage("assets/images/sun.PNG"),
                      data: weatherStationController.data == null
                          ? '0'
                          : weatherStationController.temperature.toString(),
                      unit: "°C",
                    ),
                    SizedBox(height: verticalOffset),
                    DataPresenter(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.height - 250) / 4,
                      title: "Precipitation",
                      image: const AssetImage("assets/images/cloud.PNG"),
                      data: weatherStationController.data == null
                          ? '0'
                          : weatherStationController.rainrate.toString(),
                      unit: "mm",
                    ),
                    SizedBox(height: verticalOffset),
                    Center(
                      child: Text(
                        "Weekly report",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        DataPresenter(
                          //TODO
                          width: (MediaQuery.of(context).size.width - 68) / 2,
                          height:
                              (MediaQuery.of(context).size.height - 250) / 4,
                          title: "Hottest Day",
                          image: const AssetImage("assets/images/sun.PNG"),
                          data: weatherStationController.data == null
                              ? '0'
                              : weatherStationController.maxTemperature
                                  .toString(),
                          unit: "°C",
                        ),
                        SizedBox(width: horizontalOffset),
                        DataPresenter(
                          //TODO
                          width: (MediaQuery.of(context).size.width - 68) / 2,
                          height:
                              (MediaQuery.of(context).size.height - 250) / 4,
                          title: "Coldest Day",
                          image: const AssetImage("assets/images/snow.PNG"),
                          data: weatherStationController.data == null
                              ? '0'
                              : weatherStationController.minTemperature
                                  .toString(),
                          unit: "°C",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: pageOffset),
              SensorDescription(
                text:
                    'Diese Station ist eine Kombination aus verschiedenen Sensoren. Gemessen werden Temperatur, Luftfeuchtigkeit, Luftdruck, Regen-menge, Kondensationspunkt, Windgeschwindigkeit und -richtung, Sonneneinstrahlung und Anzahl von Partikeln verschiedener Größein der Luft (Feinstaub). Die Wetterstation wird autark mittels Solar-modul betrieben. Die gemessenen Ergebnisse werden periodisch über das lokale LORAWAN Netz an unser Backend gesendet, welches die Datenzur Anzeige verarbeitet. Dieser Sensor ist Teil des LoRaParks am Weinhof. Daten und Visualisierung auf demdortigen Display oder unter lorapark.de. Die Sensordaten werden der Öffentlichkeitebenfalls auf der Ulmer Datenplattform unter CC-0-Lizenz frei verfügbar gemacht.',
                image: AssetImage("assets/images/weather_station.jpg"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = ( weatherStationController.scrollController.offset / 2);
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
