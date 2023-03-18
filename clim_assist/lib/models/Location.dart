class Location {
  int? id;
  String? name;
  double? latitude;
  double? longitude;

  Location({this.id, this.name, this.latitude, this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
