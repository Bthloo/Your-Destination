import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/data_base/models/ride_request.dart';
import '../../../../core/general_components/ColorHelper.dart';
import '../../../../core/general_components/info_buttom_sheet.dart';

class TripDetailsScreen extends StatefulWidget {
   const TripDetailsScreen({super.key});
static const String routeName = "tripDetails";

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
   final Completer<GoogleMapController> _controller =
   Completer<GoogleMapController>();
  CameraPosition kGooglePlex = const CameraPosition(
    zoom: 1,
    target: LatLng(30.314719, 31.735493),
  );

  CameraPosition kLake = const CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
  );
   Position? position;
   LocationPermission? permission;
   bool? serviceEnabled;
   double? lat1 ;
   double? long1;
   double? lat2;
   double? long2;
   double? latPos;
   double? longPos;
   LatLng? latlangg;
   List<LatLng> polylineCoordinates = [];
   List<LatLng> fromDriverCoordinates = [];
   Set<Marker> markers = {};
   BitmapDescriptor endFlagImg = BitmapDescriptor.defaultMarker;
   BitmapDescriptor startFlagImg = BitmapDescriptor.defaultMarker;

   @override
  void initState() {
     super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RideRequest arrgs = ModalRoute.of(context)!.settings.arguments as RideRequest;
      endFlag();
      startFlag();
      getPolyLines(
        sourceLat: arrgs.source!.latitude,
        sourceLong: arrgs.source!.longitude,
        destinationLat: arrgs.destination!.latitude,
        destinationLong: arrgs.destination!.longitude,
      );
     // moveCamera(poslat: latPos!,poslong: longPos!);
    });

   }
   endFlag() async {
      await BitmapDescriptor.fromAssetImage(
         const ImageConfiguration(size: Size(1, 1)),
         'assets/images/flagcrop.png'
     ).then((icon) {
       setState(() {
         endFlagImg = icon;
       });
      } );
   }
   startFlag() async {
     await BitmapDescriptor.fromAssetImage(
         const ImageConfiguration(size: Size(2, 2)),
         'assets/images/startflag.png'
     ).then((icon) {
       setState(() {
         startFlagImg = icon;
       });
     } );
   }

  @override
  Widget build(BuildContext context) {
    RideRequest arrgs = ModalRoute.of(context)!.settings.arguments as RideRequest;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorHelper.mainColor),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                showInfoSheet(
                  phoneNumber: arrgs.driverPhoneNumber??'',
                  name: arrgs.driverName??''
                );

              }, icon: const Icon(Icons.info_outline)
          )
        ],
        backgroundColor: ColorHelper.darkColor,
        title: const Text('Your Destination',style: TextStyle(
          color: ColorHelper.mainColor
        ),),

      ),
      body:
      GoogleMap(
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        polylines: {
          Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              visible: true,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              jointType: JointType.round,
              geodesic: true,
              color: ColorHelper.mainColor,
              width: 5
          ),
          Polyline(
              polylineId: const PolylineId('route1'),
              points: fromDriverCoordinates,
              visible: true,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap,
              jointType: JointType.round,
              geodesic: true,
              color: Colors.black,
              width: 5
          )
        },
        compassEnabled: true,
        indoorViewEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId('start'),
              // icon: BitmapDescriptor.,
              infoWindow: const InfoWindow(title: 'The Start of thr trip'),
              icon: startFlagImg,

              position: LatLng(arrgs.source!.latitude, arrgs.source!.longitude)),
          Marker(
              markerId: const MarkerId('end'),
              icon: endFlagImg,
              infoWindow: const InfoWindow(title: 'The End of thr trip'),
              position: LatLng(arrgs.destination!.latitude, arrgs.destination!.longitude))
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          zoom: 15,
            target: LatLng(arrgs.destination!.latitude, arrgs.destination!.longitude)),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

   void getPolyLines(
      {required double sourceLat,required double sourceLong,
        required double destinationLat,required double destinationLong
      })async {
     polylineCoordinates = [];
     PolylinePoints polylinePoints = PolylinePoints();
     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
         'AIzaSyAd-cOZHXzoELp9_6ydGOnaVPOH8zskOOU',
         PointLatLng(sourceLat, sourceLong),
         PointLatLng(destinationLat, destinationLong));
     if (result.points.isNotEmpty) {
       result.points.forEach(
             (PointLatLng point) =>
             polylineCoordinates.add(
               LatLng(
                   point.latitude, point.longitude),
             ),
       );
     }

setState(() {

});
   }

   // Future<void> moveCamera({required double poslat,required double poslong}) async {
   //   final GoogleMapController controller = await _controller.future;
   //   controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
   //     target: LatLng(poslat, poslong),
   //     zoom: 15,
   //   )));
   // }

   void showInfoSheet({required String phoneNumber, required String name}){
     showModalBottomSheet(
      // backgroundColor: ColorHelper.darkColor,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
         isScrollControlled:false,
         context: context,
         builder: (context){
           return InfoButtomSheet(
             phoneNumber: phoneNumber,
             name: name,
           );
         });
   }
}
