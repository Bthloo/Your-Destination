import 'dart:convert';

import '../models/MapSearchResponse.dart';
import 'package:http/http.dart' as http;

class ApiManager{
  static const String baseUrl = 'maps.googleapis.com';
  static Future<MapSearchResponse> search({required String keyWord}) async {
    Map<String, String> queryParams = {
      'parameters' : '',
      'key' : 'AIzaSyAd-cOZHXzoELp9_6ydGOnaVPOH8zskOOU',
      'input': keyWord,
      'inputtype' :'textquery',
      'fields' : 'geometry'
    };
    var uri = Uri.https(baseUrl,'maps/api/place/findplacefromtext/json',queryParams);
    var request = await http.get(uri);
    print(request.body);
    var search = MapSearchResponse.fromJson(jsonDecode(request.body));
    return search;
  }
}