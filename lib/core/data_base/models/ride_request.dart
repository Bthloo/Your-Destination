import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideRequest{
  static const String collectionName = 'ride-request';
  String? id;
  String? from;
  String? to;
  String? price;
  String? distance;
  String? state;
  String? time;
  GeoPoint? source ;
  GeoPoint? destination ;
  String? type;
  String? driverName;
  String? clientName;
  String? clientPhoneNumber;
  String? driverPhoneNumber;
  double? rate;
  String? note;

  RideRequest({this.id,this.rate,this.note,this.clientPhoneNumber,this.driverPhoneNumber,this.clientName,this.driverName,this.from,this.to,this.price,this.distance,this.state,this.time,this.destination,this.source,this.type});

  RideRequest.fromFireStore(Map<String,dynamic>? data):
  this(id: data?['id'],
  from: data?['from'],
  price: data?['price'],
  distance: data?['distance'],
  state: data?['state'],
  time: data?['time'],
  source: data?['source'],
  destination: data?['destination'],
  type: data?['type'],
  driverName: data?['driverName'],
  clientName: data?['clientName'],
  clientPhoneNumber: data?['clientPhoneNumber'],
  driverPhoneNumber: data?['driverPhoneNumber'],
  rate : data?['rate'],
  note: data?['note'],
  to: data?['to']);

  Map<String,dynamic> toFireStore(){
  return {
  'id':id,
  'from':from,
  'to':to,
  'price':price,
    'distance': distance,
    'state': state,
    'time' : time,
    'destination' : destination,
    'source' : source,
    'type' : type,
    'driverName' : driverName,
    'clientName' : clientName,
    'driverPhoneNumber' : driverPhoneNumber,
    'rate' : rate,
    'note' : note,
    'clientPhoneNumber' : clientPhoneNumber
  };
  }
}