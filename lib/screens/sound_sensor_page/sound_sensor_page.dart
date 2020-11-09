import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorapark_app/data/models/sensors/sound_sensor_data.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/data_presenter.dart';
import 'package:lorapark_app/screens/widgets/sensor_description/sensor_description.dart';
import 'package:lorapark_app/screens/widgets/single_sensor_view_template/single_sensor_view_template.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/screens/widgets/charts/sound_sensor_bar_chart.dart';
import 'package:lorapark_app/controller/sensor_controller/sound_controller.dart';

double clipSize = 0;
const double padding = 24.0;
const double horizontalOffset = 20;
const double verticalOffset = 24;
const double pageOffset = 20;

class SoundSensorPage extends StatefulWidget{
  @override
  _SoundSensorPage createState() => _SoundSensorPage();
}

class _SoundSensorPage extends State<SoundSensorPage>{

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
 
  @override
  Widget build(BuildContext context) {
    var _soundSensorController = Provider.of<SoundController>(context);
     return RefreshIndicator(
       onRefresh:() async => await _soundSensorController.fetchData(),
       child: SingleSensorViewTemplate(scrollController: _soundSensorController.scrollController, sliverlist:SliverList(delegate:SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataPresenter(
              title: 'Sound pressure', 
              data:_soundSensorController.data == null ? Text('0%')
              :Text(_soundSensorController.fastNoise.toString()), 
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height-250)/4,)
          ],
        ),
      )
    ]
    )) , clipSize: clipSize,
    sensorName: 'Sound Sensor', sensorNumber:'3',)
     );
    throw UnimplementedError();

    void _scrollListener() {
    setState(() {
      clipSize = ( _soundSensorController.scrollController.offset / 2);
    });
   }
  }
}