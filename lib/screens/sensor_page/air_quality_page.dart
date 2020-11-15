import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorapark_app/controller/sensor_controller/air_quality_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPage createState() => _AirQualityPage();
}

class _AirQualityPage extends State<AirQualityPage> {
  AirQualityController _airQualityController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _airQualityController = Provider.of<AirQualityController>(
      context,
      listen: false,
    );
    _airQualityController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _airQualityController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          await _airQualityController.getAirQualityDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: _airQualityController.scrollController,
        clipSize: _clipSize,
        sensorName: 'Air Quality',
        sensorNumber: '02',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: _airQualityController.data == null
                      ? _airQualityController.getAirQualityDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<AirQualityController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Air Quality Level',
                                visualization: SvgPicture.asset(
                                  'assets/icons/svg/air-quality-icon.svg',
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.getAirQualityLevel(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: verticalOffset),
                      SensorDescription(
                        text:
                            'This device contains sensors for measuring temperature and humidity and four electrochemical gas sensors. In this case the gases nitrogen dioxide (NO2), carbon monoxide (CO), ozone (O) and sulfur dioxide (SO2) are measured. This allows conclusions to be drawn about the air quality. The measurement results are periodically sent to our backend via the local LoRaWAN network and processed there for display.',
                        image:
                            AssetImage('assets/images/air-quality-sensor.jpg'),
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
      _clipSize = (_airQualityController.scrollController.offset / 2);
    });
  }
}
