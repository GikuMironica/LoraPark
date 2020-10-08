class ParkingEventData {
  int _parkingEvents;

  ParkingEventData({int parkingEvents})
      : _parkingEvents = parkingEvents;

  factory ParkingEventData.fromJson(Map<String, dynamic> json){
    return ParkingEventData(
      parkingEvents: json["parkingEvents"],
    );
  }

  int get parkingEvents => _parkingEvents;

}