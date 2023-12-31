import 'package:firebase_auth/firebase_auth.dart';

class User{// data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;
  String? phoneNumber;

  User({this.id,this.name,this.email,this.phoneNumber});

  User.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
          phoneNumber: data?['phoneNumber'],
          email: data?['email']);

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber
    };
  }
}