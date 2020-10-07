class SoundSensorData {
  double _firstdbafast;
  double _firstdbaslow;
  double _firstleqa;
  double _firstleqc;
  DateTime _timestamp;

  SoundSensorData({double firstdbafast,
    double firstdbaslow,
    double firstleqa,
    double firstleqc,
    String timestamp}) {
    this._firstdbafast = firstdbafast;
    this._firstdbaslow = firstdbaslow;
    this._firstleqa = firstleqa;
    this._firstleqc = firstleqc;
    this._timestamp = DateTime.parse(timestamp);
  }

  /// Fast noises, like a bang or an accelerating car.
  double get firstdbafast => _firstdbafast;

  /// Continuous noises like constant traffic noises
  double get firstdbaslow => _firstdbaslow;

  /// Sound pressure
  double get firstleqa => _firstleqa;

  /// Sound Pressure
  double get firstleqc => _firstleqc;

  DateTime get timestamp => _timestamp;

  SoundSensorData.fromJson(Map<String, dynamic> json) {
    _firstdbafast = json['firstdbafast'];
    _firstdbaslow = json['firstdbaslow'];
    _firstleqa = json['firstleqa'];
    _firstleqc = json['firstleqc'];
    _timestamp = DateTime.parse(json['timestamp']);
  }
}