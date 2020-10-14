import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/settings_controller/settings_controller.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingsController>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: () async => await _controller.fetchData(),
              title: Text('Jello'),
            ),
            _controller.data.isEmpty ? Text('No Data Here') : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: _controller.data.length,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                return Card(
                  child: Container(
                    child: Column(
                    children: [
                      Text('Pax Count: ${_controller.data[i].paxCount}'),
                      Text('Timestamp: ${_controller.data[i].timestamp.toString()}'),
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