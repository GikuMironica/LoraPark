import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorapark_app/controller/sensor_controller/door_controller.dart';
import 'package:lorapark_app/screens/widgets/charts/door_chart.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

class DoorPage extends StatefulWidget {
  @override
  _DoorPageState createState() => _DoorPageState();
}

class _DoorPageState extends State<DoorPage> {
  DoorController _doorController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _doorController = Provider.of<DoorController>(
      context,
      listen: false,
    );
    _doorController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _doorController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await _doorController.getDoorDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: _doorController.scrollController,
        clipSize: _clipSize,
        sensorName: 'Door',
        sensorNumber: '11',
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(24),
                child: FutureBuilder(
                  future: _doorController.data == null
                      ? _doorController.getDoorDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<DoorController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Door Openings Today',
                                visualization: SvgPicture.asset(
                                  'assets/icons/svg/open-door.svg',
                                  height: 64,
                                  width: 64,
                                ),
                                data: Text(
                                  controller
                                      .getTotalDailyNumberOfOpenings(
                                          DateTime.now())
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 36,
                                  ),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: 24),
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<DoorController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Last Opened',
                                visualization: SvgPicture.asset(
                                  'assets/icons/svg/clock.svg',
                                  height: 64,
                                  width: 64,
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
                            )
                          : LoadingDataPresenter(),
                      const SizedBox(height: 24),
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? DataPresenter(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.95,
                              title: 'Last 8 Days',
                              data: DoorChart(),
                            )
                          : LoadingDataPresenter(
                              height: MediaQuery.of(context).size.width * 0.95,
                            ),
                      const SizedBox(height: 24),
                      SensorDescription(
                        image: AssetImage('assets/images/door-sensor.jpg'),
                        text:
                            'This door opening sensor is installed at the common entrance to the digital agenda and the digitization center at Weinhof 7. A magnetic field is used to measure whether the entrance door is currently open or closed. The status is then transmitted via LoRaWAN in an energy-saving manner. A battery that lasts for several years is sufficient as a power source. The first experiments are underway to use the magnetic contact itself as a power source.',
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
      _clipSize = (_doorController.scrollController.offset / 2);
    });
  }
}
