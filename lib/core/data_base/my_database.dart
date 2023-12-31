import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/core/data_base/models/ride_request.dart';
import 'models/user.dart';

class MyDataBase{

  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  static Future<void> addUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id)async{
    var collection = getUsersCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }

  static CollectionReference<RideRequest> getRideRequestCollection(){
    return FirebaseFirestore.instance.collection(RideRequest.collectionName)
        .withConverter<RideRequest>(
      fromFirestore: (snapshot, options) => RideRequest.fromFireStore(snapshot.data()),
      toFirestore: (ride, options) => ride.toFireStore(),
    );
  }

  static Future<void> addRideRequest(RideRequest rideRequest){
    var collection = getRideRequestCollection().doc();
    rideRequest.id = collection.id;
    return collection.set(rideRequest);
  }
  static Future<void> listenState()async {
    getRideRequestCollection().doc().snapshots().listen((event) { });
  }

  static Stream<DocumentSnapshot<RideRequest>>getRideRealTimeUpdate(String id){
    return getRideRequestCollection().doc(id)
        .snapshots();
  }
  static Future<void> deleteTrip(String tripId){
    return getRideRequestCollection()
        .doc(tripId)
        .delete();
  }
  static Future<void> editRequest(RideRequest rideRequest){
    return getRideRequestCollection().doc(rideRequest.id).update(rideRequest.toFireStore());

  }
}