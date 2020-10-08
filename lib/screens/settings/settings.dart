import 'package:flutter/material.dart';
import 'package:lorapark_app/config/sensor_list.dart';
import 'package:lorapark_app/data/models/sensors.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/person_count.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PersonCountRepository personCountRepository = PersonCountRepository();
  List<PersonCountData> personCountData = [];

  Future<void> fetchData() async {
    personCountData = await personCountRepository.get(id: Sensors.personCount_one);
    setState(() {});
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
              onTap: () async => await fetchData(),
              title: Text('Jello'),
            ),
            personCountData.length == 0 ? Text('Hello') : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: personCountData.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return Card(
                  child: Container(
                    child: Column(
                    children: [
                      Text('Pax Count: ${personCountData[i].paxCount}'),
                      Text('Timestamp: ${personCountData[i].timestamp.toString()}'),
                    ],
                  ),)
                );
              },
            )
          ],
        ),
      ),
    );
  }
}