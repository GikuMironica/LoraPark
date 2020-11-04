import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/config/sensors.dart';
import 'package:lorapark_app/services/location_service/location_service.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

enum MapPageState { MAP_LOADING, MAP_ERROR, MAP_LOADED, ROUTING }

class MapController extends ChangeNotifier {
  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((MapController).toString());

  LocationService _locationService = GetIt.I.get<LocationService>();
  MapPageState _pageState = MapPageState.MAP_LOADING;

  MapPageState get pageState => _pageState;

  HereMapController _hereMapController;

  HereMapController get hereMapController => _hereMapController;


  void onMapCreated(HereMapController hereMapController) async {
    _hereMapController = hereMapController;
    if (_locationService.location == null) {
      await _locationService.getLocation();
    } else {
      _logger.e('WARNING: LOCATION ISNT NULL');
    }
    _hereMapController.mapScene.loadSceneForMapScheme(MapScheme.greyDay,
        (MapError error) {
      if (error != null) {
        _logger.e('FATAL ERROR: Map was unable to be loaded');
        _logger.e('Map Error: $error');
        setPageState(MapPageState.MAP_ERROR);
        return;
      }
      const distanceInMeters = 1000.0;
      _logger.d(
          'Setting location to ${_locationService.location.latitude}, ${_locationService.location.longitude}');
      _hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(_locationService.location.latitude,
              _locationService.location.longitude),
          distanceInMeters);
      for (var sensor in GetIt.I.get<Sensors>().list) {
        if (sensor.latitude != 0.0) {
          MapMarker marker = MapMarker(
              GeoCoordinates(sensor.latitude, sensor.longitude),
              MapImage.withFilePathAndSignedWidthAndHeight(
                  '/assets/icons/svg/location-outline.svg', 48, 48));
          _hereMapController.mapScene.addMapMarker(marker);
        }
      }
      setPageState(MapPageState.MAP_LOADED);
    });
  }

  void setPageState(MapPageState pageState) {
    _pageState = pageState;
    notifyListeners();
  }
}
