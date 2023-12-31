import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/core/api_manager/api_manager.dart';
import 'package:graduation_project/core/data_base/models/ride_request.dart';
import 'package:graduation_project/core/data_base/my_database.dart';
import 'package:graduation_project/core/general_components/build_show_toast.dart';
import 'package:graduation_project/core/general_components/custom_form_field.dart';
import 'package:graduation_project/core/general_components/dialog.dart';
import 'package:graduation_project/features/Auth/Login/ViewModel/login_cubit.dart';
import 'package:graduation_project/features/home_screen/viewmodel/search_cubit.dart';
import 'package:graduation_project/features/profile_screen/viewmodel/profile_cubit.dart';

import '../../../../core/general_components/ColorHelper.dart';
import '../../../profile_screen/view/pages/profile_screen.dart';
import '../../../waiting_screen/View/pages/waiting_screen.dart';
import '../components/lower_bodey.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  SearchCubit searchCubit = SearchCubit();

  Position? position;
  LocationPermission? permission;
  bool? serviceEnabled;
  double? lat1;
  double? long1;
  double? lat2;
  double? long2;
  // late DirectionModel directions;
  LatLng? latlangg;
  static LatLng? source;
  //LatLng(30.314675, 31.736661);
  static LatLng? destination;
  List<LatLng> polylineCoordinates = [];
  // late direction.DirectionModel directions;

  StreamSubscription<Position>? positionStream;

  double? distanceInMeters;
  double? price;
  //Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex =  const CameraPosition(
    zoom: 5,
    target: LatLng(30.314719, 31.735493),
  );

  CameraPosition kLake = const CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
  );

  Set<Marker> markers = {};

  BitmapDescriptor endFlagImg = BitmapDescriptor.defaultMarker;
  BitmapDescriptor personFlagImg = BitmapDescriptor.defaultMarker;
  endFlag() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(2, 2)),
            'assets/images/flagcrop.png')
        .then((icon) {
      setState(() {
        endFlagImg = icon;
      });
    });
  }

  startFlag() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/person.png')
        .then((icon) {
      setState(() {
        personFlagImg = icon;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentPosition();

      endFlag();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       Text('data',
      //         style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 25
      //       ),),
      //       Text('data',style: TextStyle(
      //           color: Colors.white,
      //           fontSize: 25
      //       ),),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      /* bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: ColorHelper.darkColor,
          unselectedItemColor: Colors.white,
          items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map),label: 'Request a Ride',),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],),*/

      //backgroundColor:  Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      backgroundColor: ColorHelper.darkColor,
                      contentPadding: const EdgeInsets.all(25),
                      children: [
                        Column(
                          children: [
                            Form(
                              key: formKey,
                              child: CustomFormField(
                                  hintText: 'Search',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter a place name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: searchController),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            BlocConsumer<SearchCubit, SearchState>(
                              bloc: searchCubit,
                                listener: (context,state) async {
                                  if (state is SearchSuccess) {

                                    final GoogleMapController controller = await _controller.future;
                                    await controller.animateCamera(CameraUpdate.newCameraPosition(

                                        CameraPosition(
                                          zoom: 15,
                                          target: LatLng(
                                              state.searchResponse?.candidates?[0].geometry?.location?.lat?.toDouble()??source!.latitude,
                                              state.searchResponse?.candidates?[0].geometry?.location?.lng?.toDouble()??source!.longitude
                                          ),
                                        )

                                    ));
                                    markers.add(
                                      Marker(
                                          markerId: const MarkerId('end'),
                                          icon: endFlagImg,
                                          position: LatLng(
                                              state.searchResponse!.candidates![0].geometry!.location!.lat!.toDouble(),
                                              state.searchResponse!.candidates![0].geometry!.location!.lng!.toDouble()
                                          )),
                                    );
                                    destination = LatLng(
                                        state.searchResponse!.candidates![0].geometry!.location!.lat!.toDouble(),

                                        state.searchResponse!.candidates![0].geometry!.location!.lng!.toDouble()

                                    );
                                     Navigator.pop(context);
                                     searchController.clear();
                                     setState(() {

                                     });
                                  }
                                  if (state is SearchError) {
                                    buildShowToast(state.message??"Something went wrong");
                                  }
                                },
                              builder: (context, state) {
                                if (state is SearchLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return ElevatedButton(
                                    onPressed: () {
                                      search(searchName: searchController.text);
                                    },
                                    child: const Text('Search'));
                              }
                            )
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.search)),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
            icon: const Icon(Icons.person)),
        iconTheme: const IconThemeData(color: ColorHelper.mainColor),
        centerTitle: true,
        backgroundColor: ColorHelper.darkColor,
        title: const Text(
          'Your Destination',
          style: TextStyle(color: ColorHelper.mainColor),
        ),
      ),
      body:
      source == null ?
      Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text('Please open device location',
                  style: TextStyle(
                    color: Colors.white,
                  fontSize: 25
                  )),
            SizedBox(height: 10.h,),
            ElevatedButton(
                onPressed: (){
                  currentPosition();
                  setState(() {

                  });
                },
                child: const Text('Try again')),
            ]
          ),
        ),
      ):
      Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              rotateGesturesEnabled: true,
              trafficEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(

                  southwest: const LatLng(22.809394, 31.425691),
                  northeast: const LatLng(31.563525,31.135726))),
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
                    width: 5)
              },
              onTap: (latLang) {
                latlangg = latLang;
                markers.add(
                  Marker(
                      markerId: const MarkerId('end'),
                      icon: endFlagImg,
                      position: LatLng(latLang.latitude, latLang.longitude)),
                );
                destination = latLang;
                setState(() {});
              },
              indoorViewEnabled: true,
              markers: markers,
              mapType: MapType.hybrid,
              initialCameraPosition: kGooglePlex,

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: LowerBody(
              onCalculateTab: getPolyLines,
              onRequestTab: requestRide,
              destination:
              '${((distanceInMeters ?? 0) / 1000).toStringAsFixed(1)} KM',
              price: '${price?.toStringAsFixed(2)} EGP',
            ),
          )
        ],
      )

    );
  }

  ///30.314719, 31.735493
//////
//  static LatLng source =  LatLng(30.314675, 31.736661);
  // static LatLng destination =  LatLng(30.315518, 31.736189);
  ////
  //
  // goToTheLake() async{
  //   getPolyLines();
  //   }


  search({required String searchName}){
    if(formKey.currentState!.validate() == false ){
      return;
    }
    searchCubit.search(searchName: searchName);
  }


  void requestRide() async {
    if (price == null) {
      DialogUtilities.showMessage(context,
          'Please Complete Ride information Then Enter Calculate Button',
          nigaiveActionName: 'OK');
      return;
    }
    DialogUtilities.showLoadingDialog(context, 'Loading...');
    List<Placemark> sourceName = await placemarkFromCoordinates(
        source?.latitude ?? 0, source?.longitude ?? 0);
    List<Placemark> destinationName = await placemarkFromCoordinates(
        destination?.latitude ?? 0, destination?.longitude ?? 0);
    GeoPoint? s = GeoPoint(source!.latitude, source!.longitude);
    GeoPoint? d = GeoPoint(destination!.latitude, destination!.longitude);
    RideRequest rideRequest = RideRequest(
        distance: "${(distanceInMeters ?? 0) / 1000}",
        price: price.toString(),
        from: '${sourceName[0].street}, ${sourceName[0].locality}',
        to: '${destinationName[0].street}, ${destinationName[0].locality}',
        state: 'waiting',
        time: '${DateTime.now()}',
        source: s,
        destination: d,
        type: LowerBody.selectedType,
        clientName: LoginCubit.currentUser?.name,
        clientPhoneNumber: LoginCubit.currentUser?.phoneNumber,
        driverName: 'Not Assigned',
        driverPhoneNumber: 'Not Assigned');
    MyDataBase.addRideRequest(rideRequest);
    DialogUtilities.hideDialog(context);
    Navigator.pushReplacementNamed(context, WaitingScreen.routeName,
        arguments: rideRequest);
  }

  void getPolyLines() async {
    if (destination == null) {
      DialogUtilities.showMessage(context, 'Please Complete Ride information',
          nigaiveActionName: 'Ok');
      return;
    }
    DialogUtilities.showLoadingDialog(context, 'Loading...');
    polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAd-cOZHXzoELp9_6ydGOnaVPOH8zskOOU',
        PointLatLng(source!.latitude, source!.longitude),
        PointLatLng(destination!.latitude, destination!.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      // normal 3
      // vip 5
      // motor 1.5
      distanceInMeters = Geolocator.distanceBetween(
          source?.latitude ?? 0,
          source?.longitude ?? 0,
          destination?.latitude ?? 0,
          destination?.longitude ?? 0);
      if (LowerBody.selectedType == 'Normal') {
        if (LoginCubit.currentUser.email!.endsWith('edu.eg')) {
          price = (((distanceInMeters ?? 0) / 1000) * 7) * 0.75;
        } else {
          price = ((distanceInMeters ?? 0) / 1000) * 7;
        }
        setState(() {});
      }
      if (LowerBody.selectedType == 'Comfort') {
        if (LoginCubit.currentUser.email!.endsWith('edu.eg')) {
          price = (((distanceInMeters ?? 0) / 1000) * 10) * 0.75;
        } else {
          price = ((distanceInMeters ?? 0) / 1000) * 10;
        }
        setState(() {});
      }
      if (LowerBody.selectedType == 'Motorcycle') {
        if (LoginCubit.currentUser.email!.endsWith('edu.eg')) {
          price = (((distanceInMeters ?? 0) / 1000) * 4) * 0.75;
        } else {
          price = ((distanceInMeters ?? 0) / 1000) * 4;
        }
        setState(() {});
      }
      //price = ((distanceInMeters??0)/1000)*5;
      setState(() {});
    }

    DialogUtilities.hideDialog(context);
  }

  Future<bool> isLocationEnabled() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      // return Future.error('Location services are disabled.');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<Position> currentPosition() async {
    // startFlag();

    // bool serviceEnabled;
    // LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position? position = await Geolocator.getCurrentPosition();

    //source?.latitude = position.latitude;
    source = LatLng(position.latitude, position.longitude);
    markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: source ?? const LatLng(0, 0),
        draggable: true,
        icon: personFlagImg ?? BitmapDescriptor.defaultMarker,
        onDrag: (value) {
          source = value;
        },

        //customStartIcon?? d
      ),
    );
    lat1 = position.latitude;
    long1 = position.longitude;
    setState(() {});
    return position;
  }

  streamLocation() {
    positionStream = Geolocator.getPositionStream().listen((position) {
      print(position == null
          ? 'Unknown'
          : '${position?.latitude.toString()}, ${position?.longitude.toString()}');
    });
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }
}
