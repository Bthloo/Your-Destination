import 'Candidates.dart';

/// candidates : [{"geometry":{"location":{"lat":30.42326,"lng":31.5741036},"viewport":{"northeast":{"lat":30.4344127,"lng":31.5834748},"southwest":{"lat":30.4107212,"lng":31.5571219}}}}]
/// status : "OK"

class MapSearchResponse {
  MapSearchResponse({
      this.candidates, 
      this.status,});

  MapSearchResponse.fromJson(dynamic json) {
    if (json['candidates'] != null) {
      candidates = [];
      json['candidates'].forEach((v) {
        candidates?.add(Candidates.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Candidates>? candidates;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (candidates != null) {
      map['candidates'] = candidates?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}