class TemperatureDayData {
  final String _dateTime;
  final double _nightTemp;
  final double _dayTemp;

  TemperatureDayData(this._dateTime, this._nightTemp, this._dayTemp);

  double get dayTemp => _dayTemp;

  double get nightTemp => _nightTemp;

  String get dateTime => _dateTime;
}
