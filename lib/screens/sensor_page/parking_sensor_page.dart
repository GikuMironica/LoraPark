import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/parking_sensor_controller.dart';
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

class ParkingPage extends StatefulWidget {
  @override
  _ParkingPage createState() => _ParkingPage();
}

class _ParkingPage extends State<ParkingPage> {
  ParkingSensorController _parkingController;
  double _clipSize;

  @override
  void initState() {
    _clipSize = 0;
    _parkingController = Provider.of<ParkingSensorController>(
      context,
      listen: false,
    );
    _parkingController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _parkingController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sensor = SelectedSensor.of(context).sensor;

    return RefreshIndicator(
      onRefresh: () => _parkingController.getParkingAverageDuration(7),
      child: SingleSensorViewTemplate(
        scrollController: _parkingController.scrollController,
        clipSize: _clipSize,
        sensorName: sensor.name,
        sensorNumber: sensor.number,
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<ParkingSensorController>(
                  builder: (context, controller, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _parkingController.parkingEventData.isEmpty &&
                              _parkingController.dataAvg.isEmpty
                          ? LoadingDataPresenter()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff657582).withOpacity(0.17),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Parking Duration of sensors",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(height: verticalOffset),
                      Row(
                        children: [
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #1",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                              .dataAvg[0].averageParkingDuration
                                              .toString() +
                                          " mins"),
                                  visualization: Image(
                                    image:
                                        AssetImage("assets/images/parking.PNG"),
                                    height: 40,
                                    width: 40,
                                  )),
                          SizedBox(width: horizontalOffset),
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #2",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                              .dataAvg[1].averageParkingDuration
                                              .toString() +
                                          " mins"),
                                  visualization: Image(
                                    image:
                                        AssetImage("assets/images/parking.PNG"),
                                    height: 40,
                                    width: 40,
                                  ))
                        ],
                      ),
                      SizedBox(height: verticalOffset),
                      Row(
                        children: [
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #3",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                              .dataAvg[2].averageParkingDuration
                                              .toString() +
                                          " mins"),
                                  visualization: Image(
                                    image:
                                        AssetImage("assets/images/parking.PNG"),
                                    height: 40,
                                    width: 40,
                                  )),
                          SizedBox(width: horizontalOffset),
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #4",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                              .dataAvg[3].averageParkingDuration
                                              .toString() +
                                          " mins"),
                                  visualization: Image(
                                    image:
                                        AssetImage("assets/images/parking.PNG"),
                                    height: 40,
                                    width: 40,
                                  ))
                        ],
                      ),
                      SizedBox(height: verticalOffset),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff657582).withOpacity(0.17),
                              blurRadius: 20,
                              spreadRadius: 2,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Parkings initiated",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Image(
                                image: AssetImage("assets/images/car.png"),
                                height: 50,
                                width: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: verticalOffset),
                      Row(
                        children: [
                          _parkingController.parkingEventData.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #1",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                          .parkingEventData[0].parkingEvents
                                          .toString()),
                                ),
                          SizedBox(width: horizontalOffset),
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #2",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("0 mins")
                                      : Text(_parkingController
                                          .parkingEventData[1].parkingEvents
                                          .toString()),
                                )
                        ],
                      ),
                      SizedBox(height: verticalOffset),
                      Row(
                        children: [
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #1",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                          .parkingEventData[2].parkingEvents
                                          .toString()),
                                ),
                          SizedBox(width: horizontalOffset),
                          _parkingController.parkingEventData.isEmpty &&
                                  _parkingController.dataAvg.isEmpty
                              ? LoadingDataPresenter()
                              : DataPresenter(
                                  title: "Sensor #2",
                                  height: (MediaQuery.of(context).size.height -
                                          250) /
                                      4,
                                  width:
                                      (MediaQuery.of(context).size.width - 24) /
                                          2.3,
                                  data: _parkingController.dataAvg.isEmpty
                                      ? Text("")
                                      : Text(_parkingController
                                          .parkingEventData[3].parkingEvents
                                          .toString()),
                                )
                        ],
                      ),
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
      _clipSize = (_parkingController.scrollController.offset / 2);
    });
  }
}
