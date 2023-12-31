import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/home_screen/view/components/ride_car_type.dart';

class LowerBody extends StatefulWidget {
   LowerBody({super.key,this.destination,this.price,this.onRequestTab,this.onCalculateTab});
String? price;
String? destination;
Function()? onRequestTab;
Function()? onCalculateTab;
static String? selectedType = "Normal";
  @override
  State<LowerBody> createState() => _LowerBodyState();
}

class _LowerBodyState extends State<LowerBody> {



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.h,
          width: 360.w,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      LowerBody.selectedType = "Normal";
                    });
                  },
                  child: RideCarType(
                    selectedType: LowerBody.selectedType!,
                    imgPath: 'assets/images/carCOMFORTcopy.png',
                    title: "Normal",
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      LowerBody.selectedType = "Comfort";
                    });
                  },
                  child: RideCarType(
                    selectedType: LowerBody.selectedType!,
                    imgPath: 'assets/images/carcopy.png',
                    title: "Comfort",
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      LowerBody.selectedType = "Motorcycle";
                    });
                  },
                  child: RideCarType(
                    selectedType: LowerBody.selectedType!,
                    imgPath: 'assets/images/motorcycle.png',
                    title: "Motorcycle",
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xff444444),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text('Price : ${widget.price??'0'} ',style : TextStyle(
              color: Colors.white,
              fontSize: 22
          ),),
        ),
        SizedBox(
          height: 10.h,
        ),
         Container(
           width: double.infinity,
           padding: const EdgeInsets.all(10),
           decoration: BoxDecoration(
               color: const Color(0xff444444),
               borderRadius: BorderRadius.circular(10)
           ),
           child: Text('Distance : ${widget.destination??'0'} ',style : TextStyle(
              color: Colors.white,
              fontSize: 22
        ),),
         ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              //width: MediaQuery.of(context).size.width*.5,
              child: ElevatedButton(
                onPressed: widget.onCalculateTab,
                child:  const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Calculate',style : TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),),
                ),),
            ),
            SizedBox(
             // width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onRequestTab,
                child:  const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Request',style : TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),),
                ),),
              // ),
            )
          ],
        ),
        ]
    );
  }
}
