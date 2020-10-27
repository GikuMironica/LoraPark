import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/person_count_page/person_count_page.dart';
import 'package:lorapark_app/screens/sensor_list_page/external_screen.dart';
import 'Sensor.dart';


class SensorListPage extends StatelessWidget {
  final List<Sensor> sensorList = [
    Sensor("Wetterstation 1", "19", "#18", "Am parkhaus" , MaterialPageRoute(builder: (_) {
      return ExternalScreen();
  }, ),)
    ,
    Sensor("Wetterstation 2", "170.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Besucherstrom", "180.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return PersonCountPage();
    })),
    Sensor("Gateway", "180.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
  return ExternalScreen();
  })),
    Sensor("Feinstaub", "180.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
  return ExternalScreen();
  })),
    Sensor("Offnungssensor", "180.00", "#20", "am parkhaus",MaterialPageRoute(builder: (_) {
  return ExternalScreen();
  })),
    Sensor("Schädlingsbekampfnüng", "180.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Wassertemparatür", "180.00", "#30", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Müllsensor", "180.00", "#30", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Bodenfeuchte", "180.00", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
  return ExternalScreen();
  })),
    Sensor("Smarte Bank", "10", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Lüftqualität", "10", "#30", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),

    Sensor(
        "Gerauschsensor",
        "This sensor detects short and long sounds which reacts to popping and long lasting noises",
        "#20",
        "am parkhaus",MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Donaubad", "10", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Parken", "10", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
  return ExternalScreen();
  })),
    Sensor(
        "Strukturschäden",
        "This sensor measures changes in cracks of the münster and are mainly advantageous in ares that are difficult to access",
        "#14",
        "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Hochwasser", "10", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
    Sensor("Display", "10", "#20", "am parkhaus", MaterialPageRoute(builder: (_) {
      return ExternalScreen();
    })),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: sensorList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildSensorCard(context, index)),
                //buildIWContainer(context, index)),
      ),
    );
  }

  void navigate(BuildContext context, Sensor sensor) {
    Navigator.of(context).push(sensor.callpage());
  }

  Widget buildSensorCard(BuildContext context, int index) {
    final trip = sensorList[index];
    return InkWell(
      onTap: () => navigate(context, trip)
        ,
      child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            spreadRadius: 6
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Row(
                children: <Widget>[
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey.shade300,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  trip.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    trip.sensorNumber,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                ],
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(children: <Widget>[
              Flexible(
                child: Text(
                  trip.description,
                ),
              ),
              Spacer(),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(trip.address, style: TextStyle(fontSize: 20.0)),
                Icon(Icons.arrow_forward)
              ],
            ),
          )
        ],
      ),
    )
    );
  }
}
