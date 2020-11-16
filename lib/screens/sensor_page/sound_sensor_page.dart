import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/controller/sensor_controller/sound_controller.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;

class SoundSensorPage extends StatefulWidget {
  @override
  _SoundSensorPage createState() => _SoundSensorPage();
}

class _SoundSensorPage extends State<SoundSensorPage> {
  SoundController _soundController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _soundController = Provider.of<SoundController>(
      context,
      listen: false,
    );
    _soundController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _soundController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async => await _soundController.fetchData(),
      child: SingleSensorViewTemplate(
        scrollController: _soundController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: _soundController.data.isEmpty
                      ? _soundController.fetchData()
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<SoundController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Traffic noise',
                                visualization: SvgPicture.asset(
                                  'assets/icons/svg/noise.svg',
                                  width: 200,
                                  height: 200,
                                ),
                                data: controller.data.isEmpty
                                    ? Text(
                                        '0 dBa',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(
                                        controller.continuousNoise.toString() +
                                            ' dba',
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
                          ? Consumer<SoundController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Sound Pressure',
                                visualization: SvgPicture.asset(
                                  'assets/icons/svg/sound.svg',
                                  width: 200,
                                  height: 200,
                                ),
                                data: controller.data.isEmpty
                                    ? Text(
                                        '0 dBa',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Text(
                                        controller.soundPressure.toString() +
                                            ' dba',
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
      _clipSize = (_soundController.scrollController.offset / 2);
    });
  }
}
