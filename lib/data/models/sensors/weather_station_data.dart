import 'package:flutter/cupertino.dart';
import 'package:lorapark_app/utils/date_parse.dart';

class WeatherStationData {
  String _id;
  DateTime _timeStamp;
  double _averageWindSpeed;
  String _barTrend;
  DateTime _date;
  double _dayEt;
  double _dayRain;
  String _forecastIcon;
  List<double> _leafWetness;
  int _outsideHumidity;
  int _pm1;
  int _pm10;
  int _pm25;
  double _pressure;
  int _rainRate;
  List<double> _soilMoisture;
  int _solarRadiation;
  double _temperature;
  int _uv;
  int _windDirection;
  double _windSpeed;

  WeatherStationData({
    @required String id,
    String timeStamp,
    double averageWindSpeed,
    String barTrend,
    String date,
    double dayEt,
    double dayRain,
    String forecastIcon,
    List<double> leafWetness,
    int outsideHumidity,
    int pm1,
    int pm10,
    int pm25,
    double pressure,
    int rainRate,
    List<double> soilMoisture,
    int solarRadiation,
    double temperature,
    int uv,
    int windDirection,
    double windSpeed,
  }) {
    _id = id;
    _timeStamp = DateTime.parse(timeStamp);
    _averageWindSpeed = averageWindSpeed;
    _barTrend = barTrend;
    _date = parseSensorDate(date);
    _dayEt = dayEt;
    _dayRain = dayRain;
    _forecastIcon = forecastIcon;
    _leafWetness = leafWetness;
    _outsideHumidity = outsideHumidity;
    _pm1 = pm1;
    _pm10 = pm10;
    _pm25 = pm25;
    _rainRate = rainRate;
    _soilMoisture = soilMoisture;
    _solarRadiation = solarRadiation;
    _temperature = temperature;
    _uv = uv;
    _windDirection = windDirection;
    _windSpeed = windSpeed;
  }

  factory WeatherStationData.fromJson(Map<String, dynamic> json){
    return WeatherStationData(
      id: json['id'],
      timeStamp: json['timestamp'],
      averageWindSpeed: json['avgwindspeed'],
      barTrend: json['bartrend'],
      date: json['date'],
      dayEt: json['dayet'],
      dayRain: json['dayrain'],
      forecastIcon: json['forecasticon'],
      leafWetness: json['leafwetness'].cast<double>(),
      outsideHumidity: json['outsidehumidity'],
      pm1: json['pm1'],
      pm10: json['pm10'],
      pm25: json['pm25'],
      pressure: json['pressure'],
      rainRate: json['rainrate'],
      soilMoisture: json['soilmoistures'].cast<double>(),
      solarRadiation: json['solarradiation'],
      temperature: json['temperature'],
      uv: json['uv'],
      windDirection: json['winddirection'],
      windSpeed: json['windspeed'],
    );
  }

  double get windSpeed => _windSpeed;

  int get windDirection => _windDirection;

  int get uv => _uv;

  double get temperature => _temperature;

  int get solarRadiation => _solarRadiation;

  List<double> get soilMoisture => _soilMoisture;

  int get rainRate => _rainRate;

  double get pressure => _pressure;

  int get pm25 => _pm25;

  int get pm10 => _pm10;

  int get pm1 => _pm1;

  int get outsideHumidity => _outsideHumidity;

  List<double> get leafWetness => _leafWetness;

  String get forecastIcon => _forecastIcon;

  double get dayRain => _dayRain;

  double get dayEt => _dayEt;

  DateTime get date => _date;

  String get barTrend => _barTrend;

  double get averageWindSpeed => _averageWindSpeed;

  DateTime get timeStamp => _timeStamp;

  String get id => _id;
}