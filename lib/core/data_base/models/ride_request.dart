import 'package:cloud_firestore/cloud_firestore.dart';

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
  String? driverId;
  String? clientId;
  RideRequest({this.id,this.clientId,this.driverId,this.rate,this.note,this.clientPhoneNumber,this.driverPhoneNumber,this.clientName,this.driverName,this.type,this.from,this.to,this.price,this.distance,this.state,this.time,this.destination,this.source});

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
          driverId: data?['driverId'],
          clientId: data?['clientId'],
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
      'driverId' : driverId,
      'clientId' : clientId,
      'clientPhoneNumber' : clientPhoneNumber
    };
  }
}