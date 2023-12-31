import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/Core/general_components/custom_form_field.dart';
import 'package:graduation_project/core/data_base/models/ride_request.dart';
import 'package:graduation_project/core/data_base/my_database.dart';
import 'package:graduation_project/core/general_components/ColorHelper.dart';
import 'package:graduation_project/core/general_components/notes_field.dart';
import 'package:graduation_project/features/home_screen/view/pages/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class WaitingScreen extends StatelessWidget {
   WaitingScreen({super.key});
static const String routeName = "WaitingScreen";
final TextEditingController notesController =  TextEditingController();
   RideRequest? rideRequest;
   double? rate = 0;
   StreamSubscription<Position>? positionStream;
   Position? positionNow;
   Position? positionDestination;
   LatLng? latlng;
   double? distanceInMeters = 1000;

   @override
  Widget build(BuildContext context) {
    RideRequest arrgs = ModalRoute.of(context)!.settings.arguments as RideRequest;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.darkColor,
        centerTitle: true,
        title: const Text('Your Destination',style: TextStyle(
          color: ColorHelper.mainColor
        ),),
      ),
      body:  StreamBuilder<DocumentSnapshot<RideRequest>>(
          stream: MyDataBase.getRideRealTimeUpdate(arrgs.id!),
          builder: (context, snapshot) {
            streamLocation(LatLng(
                snapshot.data?.data()?.destination?.latitude??0,
                snapshot.data?.data()?.destination?.longitude??0
            ),snapshot);
            if(snapshot.data?.data()?.state == 'waiting'){
              return
              Padding(
                padding: const EdgeInsets.all(10.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/waiting.json',
                        width: 250.w,
                        fit: BoxFit.contain
                    ),
                    const Center(
                      child: Text(
                        'Please wait until Your Driver Accept your Ride',
                        textAlign: TextAlign.center,
                        style: TextStyle(

                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          MyDataBase.deleteTrip(arrgs.id!);
                          Navigator.pushReplacementNamed(context,
                              HomeScreen.routeName);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Text('Cancel',style: TextStyle(
                              fontSize: 25
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            else if(snapshot.data?.data()?.state == 'On Going'){
              latlng = LatLng(
                  snapshot.data?.data()?.destination?.latitude??0,
                  snapshot.data?.data()?.destination?.longitude??0
              );

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  Color(0xff2C3333)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('I\'m on my way',
                          style: TextStyle(
                              color: Colors.white,
                            fontSize: 25.sp
                          ),
                        textAlign: TextAlign.center),
                    SizedBox(height: 20.h,),
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xff2C3333),
                          child: Icon(Icons.person,color: Colors.white,size: 70,),
                        ),
                        SizedBox(height: 20.h,),
                        Text('My name is ${snapshot.data?.data()?.driverName } and\nThis is my phone number',
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 20.sp
                          ),
                            textAlign: TextAlign.center),
                        SelectableText('${snapshot.data?.data()?.driverPhoneNumber }',
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp
                        ),),
                        SizedBox(height: 40.h,),

                        Text('Please call me if you need anything',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.sp
                            ),

                            textAlign: TextAlign.center),
                        SizedBox(height: 40.h,),

                        ElevatedButton(
                            onPressed: ()async{
                              Uri url = Uri(
                                  scheme: "tel",
                                  path: snapshot.data?.data()?.driverPhoneNumber
                              );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                print("Can't open dial pad.");
                              }
                              // launchUrl(
                              //   Uri(
                              //     scheme: 'tel:+201111269525',
                              //     //path: '${snapshot.data?.data()?.driverPhoneNumber}',
                              //
                              //   )
                              //  //   "tel://${snapshot.data?.data()?.driverPhoneNumber}"
                              //
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.call),
                                SizedBox(width: 10.w,),
                                Text('Call Me'),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );

            }
            else if(snapshot.data?.data()?.state == 'Complete'){
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Text('Please Rate the Trip',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                        ),),
                      SizedBox(height: 10.h,),
                      RatingBar.builder(
                        unratedColor: Colors.white,
                        onRatingUpdate: (rating) {
                          rate = rating;
                          print(rating);
                        },
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return  const Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return const Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return const Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return const Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );


                          }
                          return Container(height: 20,width : 20,color: Colors.white,);
                        },
                      ),
                      SizedBox(height: 20.h,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*.3,
                        child: NotesFormField(
                            hintText: 'Add a Note',
                            validator: (val){
                              return null;
                            },
                            controller: notesController),
                      ),
                      SizedBox(height: 20.h,),

                      ElevatedButton(
                          onPressed: (){
                            rideRequest = snapshot.data?.data();
                            rideRequest?.rate = rate??0;
                            rideRequest?.note = notesController.text?? 'null';
                            MyDataBase.editRequest(rideRequest!);
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          },
                          child: const Text('Submit')
                      )
                    ],
                  ),

                ),
              );
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          },)




    );
  }

   streamLocation(LatLng positionn,snapshot) {
     positionStream = Geolocator.getPositionStream().listen((position) {
       positionNow = position;
       distanceInMeters = Geolocator.distanceBetween(
          position.latitude ?? 0,
           position.longitude ?? 0,
           positionn.latitude,
           positionn.longitude);
       if(distanceInMeters! <= 50){
         rideRequest = snapshot.data?.data();
         rideRequest?.state = 'Complete';
         MyDataBase.editRequest(rideRequest!);
         print('vv');
       }


       print(position == null
           ? 'Unknown'
           : '${position?.latitude.toString()}, ${position?.longitude.toString()}  $distanceInMeters');
     });
   }
}
