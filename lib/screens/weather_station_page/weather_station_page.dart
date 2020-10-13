import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/sensor_number.dart';
import 'package:lorapark_app/controllers/weather_station_controller.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
ScrollController _scrollController;
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
    var weatherStationController =
        Provider.of<WeatherStationController>(context);

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.only(left: 40, top: 50, right: 20),
              height:
                  (MediaQuery.of(context).size.height / 2 - clipSize * 0.5) <=
                          100
                      ? 100
                      : MediaQuery.of(context).size.height / 2 - clipSize * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF121212),
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: () =>
                weatherStationController.getActualWeatherStationData(),
            child: CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Color(0xFF121212),
                  pinned: true,
                  floating: false,
                  expandedHeight: MediaQuery.of(context).size.height / 4,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: FittedBox(
                      alignment: Alignment.bottomLeft,
                      fit: BoxFit.scaleDown,
                      child: const Text(
                        "Weather station",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    background: Padding(
                      padding: const EdgeInsets.all(padding),
                      child: SensorNumber(
                          number: '01',
                          showUrl: false,
                          size: 12.0,
                          dark: false),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    alignment: Alignment.bottomLeft,
                    onPressed: () {
                      /* ... */ //#TODO
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DataPresenter(
                              context: context,
                              width: MediaQuery.of(context).size.width,
                              height:
                                  (MediaQuery.of(context).size.height - 250) /
                                      4,
                              text: "Temperature",
                              image: const AssetImage("assets/images/sun.PNG"),
                              data: weatherStationController.data == null
                                  ? '0'
                                  : weatherStationController.temperature
                                      .toString(),
                              unit: "°C",
                            ),
                            SizedBox(height: verticalOffset),
                            DataPresenter(
                              context: context,
                              width: MediaQuery.of(context).size.width,
                              height:
                                  (MediaQuery.of(context).size.height - 250) /
                                      4,
                              text: "Precipitation",
                              image:
                                  const AssetImage("assets/images/cloud.PNG"),
                              data: weatherStationController.data == null
                                  ? '0'
                                  : weatherStationController.rainrate
                                      .toString(),
                              unit: "mm",
                            ),
                            SizedBox(height: verticalOffset),
                            Center(
                              child: Text(
                                "Weekly report",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto Condensed',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                DataPresenter(
                                  //TODO
                                  context: context,
                                  width:
                                      (MediaQuery.of(context).size.width - 68) /
                                          2,
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  text: "Hottest Day",
                                  image:
                                      const AssetImage("assets/images/sun.PNG"),
                                  data: weatherStationController.data == null
                                      ? '0'
                                      : weatherStationController.temperature
                                          .toString(),
                                  unit: "°C",
                                ),
                                SizedBox(width: horizontalOffset),
                                DataPresenter(
                                  //TODO
                                  context: context,
                                  width:
                                      (MediaQuery.of(context).size.width - 68) /
                                          2,
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  text: "Coldest Day",
                                  image: const AssetImage(
                                      "assets/images/snow.PNG"),
                                  data: weatherStationController.data == null
                                      ? '0'
                                      : weatherStationController.temperature
                                          .toString(),
                                  unit: "°C",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: pageOffset),
                      Padding(
                        padding: const EdgeInsets.all(padding),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff657582).withOpacity(0.17),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/weather_station.jpg"),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 50),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const Text(
                                'Diese Station ist eine Kombination aus verschiedenen Sensoren. Gemessen werden Temperatur, Luftfeuchtigkeit, Luftdruck, Regen-menge, Kondensationspunkt, Windgeschwindigkeit und -richtung, Sonneneinstrahlung und Anzahl von Partikeln verschiedener Größein der Luft (Feinstaub). Die Wetterstation wird autark mittels Solar-modul betrieben. Die gemessenen Ergebnisse werden periodisch über das lokale LORAWAN Netz an unser Backend gesendet, welches die Datenzur Anzeige verarbeitet. Dieser Sensor ist Teil des LoRaParks am Weinhof. Daten und Visualisierung auf demdortigen Display oder unter lorapark.de. Die Sensordaten werden der Öffentlichkeitebenfalls auf der Ulmer Datenplattform unter CC-0-Lizenz frei verfügbar gemacht.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto Condensed',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = (_scrollController.offset / 2);
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
