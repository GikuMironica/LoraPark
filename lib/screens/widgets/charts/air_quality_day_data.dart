class AirQualityDayData {
  final String _dateTime;
  final double _noconcentration;
  final double _no2concentration;
  final double _coconcentration;

  AirQualityDayData(this._dateTime, this._noconcentration,
      this._no2concentration, this._coconcentration);

  double get noconcentration => _noconcentration;

  double get no2concentration => _no2concentration;

  double get coconcentration => _coconcentration;

  String get dateTime => _dateTime;
}
