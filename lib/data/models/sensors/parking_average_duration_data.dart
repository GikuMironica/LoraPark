class ParkingAverageDurationData {
  int _averageParkingDuration;

  ParkingAverageDurationData({int averageParkingDuration})
     : _averageParkingDuration = averageParkingDuration;

  factory ParkingAverageDurationData.fromJson(Map<String, dynamic> json){
    return ParkingAverageDurationData(
      averageParkingDuration: json["averageParkingDuration"],
    );
  }

  int get averageParkingDuration => _averageParkingDuration;

}