import 'package:flutter/cupertino.dart';
import 'package:lorapark_app/data/models/sensors/weather_station_data.dart';
import 'package:lorapark_app/data/repositories/sensor_repository/weather_station.dart';

class WheatherStationController extends ChangeNotifier{
  WeatherStationRepository _repository = WeatherStationRepository();

  List<WeatherStationData> _data;

  Future<void>  getActualWeatherData(String id) async{
    _data = await _repository.get(id: id).whenComplete(() => notifyListeners());

   print(_data.first.temperature);

    //notifyListeners();
  }

double get temperature => _data.first.temperature;
  double get rainrate => _data.first.rainRate;
  List<WeatherStationData> get data => _data;
}