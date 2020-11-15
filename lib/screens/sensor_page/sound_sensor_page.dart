import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/data/models/sensors/sound_sensor_data.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/controller/sensor_controller/sound_controller.dart';

double clipSize = 0;
const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
var soundController;
const double pageOffset = 20;

class SoundSensorPage extends StatefulWidget {
  @override
  _SoundSensorPage createState() => _SoundSensorPage();
}

class _SoundSensorPage extends State<SoundSensorPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    soundController = Provider.of<SoundController>(
      context,
      listen: false,
    );
    soundController.scrollController.addListener(_scrollListener);
    return RefreshIndicator(
      onRefresh: () => soundController.fetchData(),
      child: SingleSensorViewTemplate(
        scrollController: soundController.scrollController,
        clipSize: clipSize,
        sensorName: "Sound sensor",
        sensorNumber: "2",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<SoundController>(
                    builder: (context, controller, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            soundController.data.isEmpty
                                ? LoadingDataPresenter()
                                : DataPresenter(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                250) / 4,
                                    title: 'Traffic noise',
                                    visualization: Image(
                                      image:
                                          AssetImage('assets/images/sound-sensor.jpg'),
                                      height: 200,
                                      width: 200,
                                    ),
                                    data: soundController.data.isEmpty
                                        ? Text(
                                            '0 dBa',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            soundController.continuousNoise
                                                    .toString() + ' dba',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                            soundController.data.isEmpty
                                ? LoadingDataPresenter()
                                : DataPresenter(
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                250) / 4,
                                    title: 'Sound Pressure',
                                    visualization: Image(
                                      image:
                                          AssetImage('assets/images/sound-sensor.jpg'),
                                      height: 200,
                                      width: 200,
                                    ),
                                    data: soundController.data.isEmpty
                                        ? Text(
                                            '0 dBa',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            soundController.soundPressure
                                                    .toString() + ' dba',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                            SizedBox(height: pageOffset / 2),
                            SensorDescription(
                                text:
                                    'Mit der ToxProtect bleiben sowohl der Köder als auch das Gift in einer sicheren Box. Die derzeitige Situation wird mit Lichtschranken kontinuierlich überwacht und via LoRaWAN übertragen. Um Ratten anzulocken werden Lockköder eingesetzt, welche die Zahl der täglichen Besuche steigert. Nach einigen Tagen, in denen die Box regelmäßig von Ratten besucht wird, folgt dann der Wechsel zum Giftköder. Nach Wirkung des Gifts, geht die Anzahl an Ratten stetig zurück. Alles wird in Echtzeit überwacht und kann bei Bedarf angepasst werden.',
                                image:
                                    AssetImage('assets/images/rat_sensor.png'))
                          ],
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    setState(() {
      clipSize = (soundController.scrollController.offset / 2);
    });
  }
}
