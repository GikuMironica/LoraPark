import 'package:get_it/get_it.dart';
import 'package:lorapark_app/services/logging_service/logging_service.dart';

/// When the sensor returns date as d/m/y h:m:s convert into a DateTime object
DateTime parseSensorDate(String dateTimeStamp) {
  if (dateTimeStamp.length != 19) {
    var date = dateTimeStamp.split(' ').first.split('/');
    var time = dateTimeStamp.split(' ').last.split(':');
    if (date.length != 3 && time.length != 3) {
      return DateTime(
        int.parse(date[2]),
        int.parse(date[1]),
        int.parse(date[0]),
        int.parse(time[0]),
        int.parse(time[1]),
        int.parse(time[2]),
      );
    } else {
      var errorString = 'Error while parsing the sensor date, is the format d/m/y h:m:s ?';
      GetIt.I.get<LoggingService>().getLogger('LoRaPark').e(errorString);
    }
  }
  return null;
}
