import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/ground_humidity_controller.dart';
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
var groundHumidityController;
double clipSize = 0;
bool isInit = true;
bool isLoading = true;

class GroundHumidityPage extends StatefulWidget {
  @override
  _GroundHumidityPage createState() => _GroundHumidityPage();
}

class _GroundHumidityPage extends State<GroundHumidityPage> {
  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;

      groundHumidityController = Provider.of<GrouundHumidityController>(
        context,
        listen: false,
      );

      groundHumidityController.getActualGroundHumidityData().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    groundHumidityController = Provider.of<GrouundHumidityController>(
      context,
      listen: false,
    );
    groundHumidityController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => groundHumidityController.getActualGroundHumidityData(),
      child: SingleSensorViewTemplate(
        scrollController: groundHumidityController.scrollController,
        clipSize: clipSize,
        sensorName: "Ground Humidity",
        sensorNumber: "09",
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
                                  (MediaQuery.of(context).size.height - 250) /
                                      4,
                              title: "Volumetric Water Content",
                              visualization: Image(
                                image: AssetImage("assets/images/vwc.png"),
                                height: 200,
                                width: 200,
                              ),
                              data: groundHumidityController.data == null
                                  ? Text(
                                      '0 %',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      groundHumidityController.vwc.toString() +
                                          " " +
                                          "%",
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
                                  (MediaQuery.of(context).size.height - 250) /
                                      4,
                              title: "Ground Temperature",
                              visualization: Image(
                                image: AssetImage("assets/images/temp.png"),
                                height: 200,
                                width: 200,
                              ),
                              data: groundHumidityController.data == null
                                  ? Text(
                                      '0 °C',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      groundHumidityController.temperature
                                              .toString() +
                                          " " +
                                          "°C",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ),
                    ]),
              ),
              SizedBox(height: pageOffset),
              SensorDescription(
                text:
                    "Dieser Sensor befindet sich im Boden in circa 50 cm Tiefe. Dort misstder Sensor die elektrische Leitfähigkeit, den Volumenwassergehalt, dieTemperatur und den Grad der Wassersättigung im Boden. Über einKabel ist der Sensor mit dem oberhalb der Bodenoberfläche befindli-chen Sendemodul verbunden. Auf diese Weise kann eine gezielte undsparsame Bewässerung erfolgen. Die Messdaten werden periodisch über das lokale LORAWAN Netzan unser Backend gesendet. Diese Daten werden dort zur Anzeigeverarbeitet.",
                image: AssetImage("assets/images/ground_humidity.jpg"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = (groundHumidityController.scrollController.offset / 2);
    });
  }
}
