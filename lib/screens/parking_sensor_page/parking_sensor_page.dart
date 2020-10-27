import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/sensor_controller/parking_sensor_controller.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';

const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;
var parkingController;
double clipSize = 0;
bool isInit = true;
bool isLoading = true;
bool isEventLoading = true;

class ParkingPage extends StatefulWidget {
  @override
  _ParkingPage createState() => _ParkingPage();
}

class _ParkingPage extends State<ParkingPage> {

  @override
  Widget build(BuildContext context) {
   parkingController = Provider.of<ParkingSensorController>(
      context,
      listen: false,
    );

   parkingController.scrollController.addListener(_scrollListener);

    return RefreshIndicator(
      onRefresh: () =>parkingController.getParkingAverageDuration(7),
      child: SingleSensorViewTemplate(
        scrollController: parkingController.scrollController,
        clipSize: clipSize,
        sensorName: "Parking sensor",
        sensorNumber: "xx",
        sliverlist: SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Consumer<ParkingSensorController>(
                  builder: (context, controller, _) =>
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty
                        ? LoadingDataPresenter()
                        : Container(
                         width: MediaQuery.of(context).size.width,
                         height:100,
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
                            children: [FittedBox(
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
                            )],
                          ),
                        ),
                    ),
                    SizedBox(height: verticalOffset),
                    Row(
                      children: [ parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ? 
                      LoadingDataPresenter() : 
                      DataPresenter(
                      title: "Sensor #1",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width: (MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.dataAvg[0].averageParkingDuration.toString()+ " mins"),
                      visualization: Image(
                              image: AssetImage("assets/images/parking.PNG"),
                              height: 40,
                              width: 40,
                      )),
                      SizedBox(width:horizontalOffset),
                      
                       parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ?
                      LoadingDataPresenter() :
                      DataPresenter(
                      title: "Sensor #2",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width:(MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.dataAvg[1].averageParkingDuration.toString()+ " mins"),
                      visualization: Image(
                              image: AssetImage("assets/images/parking.PNG"),
                              height: 40,
                              width: 40,
                      ))
                      ],
                    ),
                     SizedBox(height: verticalOffset),
                     Row(
                      children: [ parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty == null ? 
                      LoadingDataPresenter() : 
                      DataPresenter(
                      title: "Sensor #3",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                     width:(MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.dataAvg[2].averageParkingDuration.toString()+ " mins"),
                      visualization: Image(
                              image: AssetImage("assets/images/parking.PNG"),
                              height: 40,
                              width: 40,
                      )),
                      SizedBox(width:horizontalOffset),
                     parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ?
                      LoadingDataPresenter() :
                      DataPresenter(
                      title: "Sensor #4",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width: (MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.dataAvg[3].averageParkingDuration.toString()+ " mins"),
                      visualization: Image(
                              image: AssetImage("assets/images/parking.PNG"),
                              height: 40,
                              width: 40,
                      ))
                      ],
                    ),
                     SizedBox(height:verticalOffset),
                    Container(
                         width: MediaQuery.of(context).size.width,
                         height:100,
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
                            children: [FittedBox(
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
                            Image(image:AssetImage("assets/images/car.png"),
                            height: 50,
                            width: 50,)],
                          ),
                        ),
                    ),
                    SizedBox(height: verticalOffset),
                    Row(
                      children: [parkingController.parkingEvents == null ? 
                      LoadingDataPresenter() : 
                      DataPresenter(
                      title: "Sensor #1",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width: (MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.parkingEventData[0].parkingEvents.toString()),
                      ),
                      SizedBox(width:horizontalOffset),
                      
                      parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ?
                      LoadingDataPresenter() :
                      DataPresenter(
                      title: "Sensor #2",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width:(MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("0 mins") : Text(parkingController.parkingEventData[1].parkingEvents.toString()),
                      )
                      ],
                    ),
                    SizedBox(height: verticalOffset),
                    Row(
                      children: [ parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ? 
                      LoadingDataPresenter() : 
                      DataPresenter(
                      title: "Sensor #1",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width: (MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.parkingEventData[2].parkingEvents.toString()),
                      ),
                      SizedBox(width:horizontalOffset),
                      
                       parkingController.parkingEventData.isEmpty && parkingController.dataAvg.isEmpty ?
                      LoadingDataPresenter() :
                      DataPresenter(
                      title: "Sensor #2",
                      height:(MediaQuery.of(context).size.height - 250) / 4 ,
                      width:(MediaQuery.of(context).size.width - 24) / 2.3,
                      data: parkingController.dataAvg == null ? Text("") : Text(parkingController.parkingEventData[3].parkingEvents.toString()),
                      )
                      ],
                    ),
                     SizedBox(height: pageOffset/2),
              SensorDescription(
                text: "Im Beispiel sehen Sie eine Live-Ansicht der belegten E-Ladeplätze im Parkhaus am Rathaus, Neue Mitte. Zur Erkennung von freien oder belegten Parkplätzen werden Parksensoren eingesetzt, die den Belegungsstatus drahtlos per LoRaWAN übertragen und hier in Echtzeit anzeigen.",
                image: AssetImage("assets/images/parking_sensor.png")
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
      clipSize = (parkingController.scrollController.offset / 2);
    });
  }
}
