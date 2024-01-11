
class Driver{// data class
  static const String collectionName = 'drivers';
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? license;
  String? nationalID;

  Driver({this.id,this.name,this.email,this.phoneNumber,this.license,this.nationalID});

  Driver.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
          phoneNumber: data?['phoneNumber'],
          license: data?['license'],
          nationalID: data?['nationalID'],
          email: data?['email']);

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber,
      'license':license,
      'nationalID': nationalID
    };
  }
}