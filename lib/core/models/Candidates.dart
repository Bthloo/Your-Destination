import 'Geometry.dart';

/// geometry : {"location":{"lat":30.42326,"lng":31.5741036},"viewport":{"northeast":{"lat":30.4344127,"lng":31.5834748},"southwest":{"lat":30.4107212,"lng":31.5571219}}}

class Candidates {
  Candidates({
      this.geometry,});
  Candidates.fromJson(dynamic json) {
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }
  Geometry? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }

}