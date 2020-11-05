import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/data/models/sensor.dart';

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
              onTap: () {
                for(var sensor in GetIt.I.get<Sensors>().list){
                  print('${sensor.number} - ${sensor.name} - ${sensor.latitude},${sensor.longitude}');
                }
              },
              title: Text('Jello'),
            ),
           ],
        ),
      ),
    );
  }
}