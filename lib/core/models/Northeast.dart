/// lat : 30.4344127
/// lng : 31.5834748

class Northeast {
  Northeast({
      this.lat, 
      this.lng,});

  Northeast.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }

}