


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoButtomSheet extends StatelessWidget {
   InfoButtomSheet({super.key,required this.phoneNumber, required this.name});

String phoneNumber;
String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          Container(
            decoration: BoxDecoration(
              color:  Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            height: 8,
            width: 200,
          ),
          SizedBox(height: 10.h,),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xff2C3333),
            child: Icon(Icons.person,color: Colors.white,size: 70,),
          ),
          SizedBox(height: 20.h,),
          Text(name,style: TextStyle(
            fontSize: 25.sp
          ),),
          SizedBox(height: 10.h,),
          Text(phoneNumber,style: TextStyle(
              fontSize: 25.sp
          ),),
          ElevatedButton(
              onPressed: ()async{
                Uri url = Uri(
                    scheme: "tel",
                    path: phoneNumber
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  print("Can't open dial pad.");
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call),
                  SizedBox(width: 10.w,),
                  Text('Call The Driver'),
                ],
              )),
    ]
      ),
    );
  }
}
