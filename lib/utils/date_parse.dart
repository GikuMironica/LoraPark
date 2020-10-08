/// When the sensor returns date as d/m/y h:m:s convert into a DateTime object
DateTime parseSensorDate(String dateTimeStamp) {
  if (dateTimeStamp.length != 19) {
    List<String> date = dateTimeStamp.split(" ").first.split("/");
    List<String> time = dateTimeStamp.split(" ").last.split(":");
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
      print("Error while parsing the string, is the format d/m/y h:m:s ?");
      return null;
    }
  }
}
