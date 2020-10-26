import 'package:intl/intl.dart';

String getWeekday(String date,
    {String weekdayFormat = 'EEE', bool showToday = false}) {
  var formatter = DateFormat(weekdayFormat);
  var dateTime = getDateTime(date);

  return dateTime.day == DateTime.now().day && showToday
      ? 'Tdy'
      : formatter.format(dateTime);
}

DateTime getDateTime(String date) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date + ' 00:00:00');
}

List<String> getDistinctDatesAsString(Iterable<DateTime> dates,
    {String dateFormat = 'yyyy-MM-dd'}) {
  var formatter = DateFormat(dateFormat);
  return dates.map((date) => formatter.format(date)).toSet().toList();
}
