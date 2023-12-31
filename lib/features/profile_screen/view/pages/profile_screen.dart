import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/general_components/ColorHelper.dart';
import '../../../Auth/Login/View/Pages/login_screen.dart';
import '../../../Auth/Login/ViewModel/login_cubit.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
static const String routeName = "profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: ColorHelper.mainColor
        ),
        centerTitle: true,
        backgroundColor: ColorHelper.darkColor,
        title: const Text('Profile',style: TextStyle(
            color: ColorHelper.mainColor
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xff2C3333),
                child: Icon(Icons.person,color: Colors.white,size: 70,),
              ),
              SizedBox(height: 20.h,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:  Color(0xff2C3333)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      LoginCubit.currentUser?.name??''
                      ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp
                  )),
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:  Color(0xff2C3333)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      LoginCubit.currentUser?.phoneNumber??''
                  ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp
                  )),
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:  Color(0xff2C3333)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                      LoginCubit.currentUser?.email??''
                      ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp
                  )),
                ),
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                  onPressed: (){
                    LoginCubit().logout();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,
                            (route) => false);
                  },
                  child: Text('Logout',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
