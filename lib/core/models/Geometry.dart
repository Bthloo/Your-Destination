import 'Location.dart';
import 'Viewport.dart';

/// location : {"lat":30.42326,"lng":31.5741036}
/// viewport : {"northeast":{"lat":30.4344127,"lng":31.5834748},"southwest":{"lat":30.4107212,"lng":31.5571219}}

class Geometry {
  Geometry({
      this.location, 
      this.viewport,});

  Geometry.fromJson(dynamic json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport = json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  Location? location;
  Viewport? viewport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (viewport != null) {
      map['viewport'] = viewport?.toJson();
    }
    return map;
  }

}