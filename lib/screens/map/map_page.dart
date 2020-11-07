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
              builder: (ctx, controller, user, child) {
            if (controller.pageState == MapPageState.MAP_LOADED) {
              var geoCoordinates =
              GeoCoordinates(user.latitude, user.longitude);
              if(controller.userMapMarker != null){
                if(controller.userMapMarker.coordinates != geoCoordinates) {
                  controller.userMapMarker.coordinates = geoCoordinates;
                }
              } else {
                controller.userMapMarker = MapMarker.withAnchor(
                    geoCoordinates,
                    controller.userMapIcon,
                    Anchor2D());
                controller.hereMapController.mapScene
                    .addMapMarker(controller.userMapMarker);
              }
            }
            return HereMap(
              onMapCreated: controller.onMapCreated,
            );
          }),
        ),
      ],
    );
  }
}
