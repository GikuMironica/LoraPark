import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/controller/sensor_controller/door_controller.dart';
import 'package:lorapark_app/screens/widgets/charts/door_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';
import 'package:provider/provider.dart';

class DoorPage extends StatefulWidget {
  @override
  _DoorPageState createState() => _DoorPageState();
}

class _DoorPageState extends State<DoorPage> {
  double clipSize = 0;

  @override
  Widget build(BuildContext context) {
    var doorController = Provider.of<DoorController>(
      context,
      listen: false,
    );
    doorController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () => doorController.getDoorDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: doorController.scrollController,
        clipSize: clipSize,
        sensorName: 'Door',
        sensorNumber: '11',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(24),
              child: Consumer<DoorController>(
                builder: (_, controller, __) => Column(
                  children: [
                    doorController.data == null
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.3,
                            title: 'Door Openings Today',
                            visualization: Icon(
                              Icons.sensor_door_outlined,
                              color: Color(0xff2c5364),
                              size: 60,
                            ),
                            data: Text(
                              controller
                                  .getTotalDailyNumberOfOpenings(DateTime.now())
                                  .toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 36,
                              ),
                            ),
                          ),
                    const SizedBox(height: 24),
                    doorController.data == null
                        ? LoadingDataPresenter()
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.3,
                            title: 'Last Opened',
                            visualization: Icon(
                              Icons.access_time_rounded,
                              size: 60,
                              color: Color(0xff2c5364),
                            ),
                            data: Text(
                              controller.getLastOpeningTime(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 36,
                              ),
                            ),
                          ),
                    const SizedBox(height: 24),
                    doorController.data == null
                        ? LoadingDataPresenter(height: MediaQuery.of(context).size.width * 0.95,)
                        : DataPresenter(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.95,
                            title: 'Last 8 Days',
                            data: DoorChart(),
                          ),
                    const SizedBox(height: 24),
                    SensorDescription(
                      image: AssetImage('assets/images/door.jpg'),
                      text:
                          'Dieser Türöffnungssensor ist am gemeinsamen Eingang zur Digitalen Agenda und zum Digitalisierungszentrum am Weinhof 7 verbaut. Über ein Magnetfeld wird gemessen, ob die Eingangstüre gerade geöffnet oder geschlossen ist. Anschließend wird der Status über LoRaWAN energiesparend übertragen. Als Stromquelle genügt hierfür eine Batterie, welche mehrere Jahre hält. Es laufen erste Experimente, den Magnetkontakt selbst als Stromquelle zu benutzen.',
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _scrollListener() {
    var wasteLevelController = Provider.of<DoorController>(
      context,
      listen: false,
    );

    setState(() {
      clipSize = (wasteLevelController.scrollController.offset / 2);
    });
  }
}
