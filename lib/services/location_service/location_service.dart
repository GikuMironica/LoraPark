import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:lorapark_app/data/models/coordinates.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';
import 'package:lorapark_app/utils/rounding_decimal_places.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as l;

class LocationService extends ChangeNotifier {
  final Logger _logger =
      GetIt.I.get<LoggingService>().getLogger((LocationService).toString());
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  l.Location _location;
  UserLocation _userLocation;

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  UserLocation get location => _userLocation;

  PermissionStatus get permissionStatus => _permissionStatus;

  LocationService() {
    _location = l.Location();
    checkPermissions();
    _location.requestPermission().then((value) async {
      if (value == l.PermissionStatus.granted) {
        var _lastLocation;
        _location.onLocationChanged.listen((e) async {
          if(e != null) {
            if (_lastLocation != null) {
              final newLatitude = roundOff(5, e.latitude);
              final newLongtiude = roundOff(5, e.longitude);
              if (_lastLocation.latitude != newLatitude &&
                  _lastLocation.longitude != newLongtiude) {
                _logger.d('User Location: $newLatitude, $newLongtiude');
                 _lastLocation = UserLocation(newLatitude, newLongtiude);
                _locationController.add(_lastLocation);
                notifyListeners();
              }
            } else {
              _lastLocation = UserLocation(e.latitude, e.longitude);
            }
          }
        });
        notifyListeners();
      }
    });
  }

  Future<UserLocation> getLocation() async {
    await requestPermisions().then((granted) async {
      var locationData = await _location.getLocation();
      _userLocation =
          UserLocation(locationData.latitude, locationData.longitude);
      _logger.d('Got the user\'s location :)');
      return _userLocation;
    });
    notifyListeners();
  }

  Future<void> checkPermissions() async {
    var newStatus = await Permission.location.status;
    _logger.d('CheckPermissions returned ${newStatus.toString()}');
    setPermissionStatus(newStatus);
    if (newStatus == PermissionStatus.granted) {
      await getLocation();
    }
    notifyListeners();
  }

  Future<void> requestPermisions() async {
    setPermissionStatus(await Permission.location.request());
  }

  void setPermissionStatus(PermissionStatus status) {
    _permissionStatus = status;
    notifyListeners();
  }
}
