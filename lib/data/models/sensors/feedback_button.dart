import 'package:lorapark_app/config/consts.dart';

class FeedbackButtonData {
  DateTime _timestamp;
  int _button1;
  int _button2;
  int _button3;
  int _button4;

  FeedbackButtonData({String timestamp,
    int button1,
    int button2,
    int button3,
    int button4}) {
    this._timestamp = DateTime.parse(timestamp);
    this._button1 = button1;
    this._button2 = button2;
    this._button3 = button3;
    this._button4 = button4;
  }

  DateTime get timestamp => _timestamp;
  int get button1 => _button1;
  int get button2 => _button2;
  int get button3 => _button3;
  int get button4 => _button4;

  FeedbackButtonData.fromJson(Map<String, dynamic> json) {
    _timestamp = DateTime.parse(json['timestamp']);
    _button1 = json['button1'];
    _button2 = json['button2'];
    _button3 = json['button3'];
    _button4 = json['button4'];
  }
}