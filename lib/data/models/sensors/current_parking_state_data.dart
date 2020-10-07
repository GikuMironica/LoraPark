class CurrentParkingStateData {
  int _occupied;

  CurrentParkingStateData({int occupied})
      : _occupied = occupied;

  factory CurrentParkingStateData.fromJson(Map<String, dynamic> json){
    return CurrentParkingStateData(
      occupied: json["occupied"],
    );
  }

  int get occupied => _occupied;

}