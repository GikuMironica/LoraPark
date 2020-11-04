import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:lorapark_app/controller/map_controller/map_controller.dart';
import 'package:provider/provider.dart';
import 'package:lorapark_app/data/models/coordinates.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Consumer2<MapController, UserLocation>(
            builder: (ctx, controller, user, child){
              if(controller.pageState == MapPageState.MAP_LOADED){
                var coordinate = GeoCoordinates(user.longitude, user.latitude);
                controller.hereMapController.camera.lookAtPoint(coordinate);
              }
              return HereMap(
              onMapCreated: controller.onMapCreated,
            );}
          ),
        ),
      ],
    );
  }
}
