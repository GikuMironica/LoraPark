import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/person_count_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor/selected_sensor.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;

class PersonCountPage extends StatefulWidget {
  @override
  _PersonCountPage createState() => _PersonCountPage();
}

class _PersonCountPage extends State<PersonCountPage> {
  PersonCountController _personCountController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _personCountController = Provider.of<PersonCountController>(
      context,
      listen: false,
    );
    _personCountController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _personCountController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () async =>
          await _personCountController.getPersonDataByTime(7),
      child: SingleSensorViewTemplate(
        scrollController: _personCountController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: FutureBuilder(
                  future: _personCountController.data == null
                      ? _personCountController.getPersonDataByTime(7)
                      : null,
                  builder: (context, snapshot) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.connectionState == ConnectionState.done ||
                              snapshot.connectionState == ConnectionState.none
                          ? Consumer<PersonCountController>(
                              builder: (_, controller, __) => DataPresenter(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.3,
                                title: 'Number of people',
                                visualization: Image(
                                  image: AssetImage('assets/images/group.png'),
                                  height: 200,
                                  width: 200,
                                ),
                                data: Text(
                                  controller.paxCount.toString() + ' people',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : LoadingDataPresenter(),
                      SizedBox(height: pageOffset / 2),
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
      _clipSize = (_personCountController.scrollController.offset / 2);
    });
  }
}
