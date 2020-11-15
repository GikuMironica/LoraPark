import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/sensor_repository.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: () async {
                  final response = await GetIt.I.get<SoundSensorRepository>().get(id: SensorEndpoints.soundSensor_one);
                  print(response.toString());
                },
              title: Text('Jello'),
            ),
           ],
        ),
      ),
    );
  }
}