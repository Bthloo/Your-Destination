import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/Auth/Login/View/Pages/login_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/data_base/models/user.dart';
import '../../../../core/data_base/my_database.dart';
import '../../../Auth/Login/ViewModel/login_cubit.dart';
import '../../../Auth/Register/View/Pages/register_screen.dart';
import 'package:flutter/scheduler.dart';
import '../../../../core/data_base/models/user.dart' as  user_model;
import '../../../home_screen/view/pages/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';
  @override
  Widget build(BuildContext context) {
   // checkId();
    Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(
          context,
          (LoginCubit.currentUser.id == ''|| LoginCubit.currentUser.id == null)
              ?LoginScreen.routeName
              : HomeScreen.routeName,
        );
    });


    // Future.delayed(const Duration(seconds: 3), () {
    //   // Navigator.pushReplacementNamed(
    //   //   context,
    //   //   (LoginCubit.user.id == ''|| LoginCubit.user.id == null)
    //   //       ?RegisterScreen.routeName
    //   //       : UserHome.routeName,
    //   // );
    //
    //   SchedulerBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    //   });
    //
    //   //Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
    //   //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterScreen(),), (route) => false);
    // });
    return  Scaffold(
      backgroundColor: Color(0xff171717),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/animation_lo1opd4s.json',
           width: 250.w,
              fit: BoxFit.contain
            ),
            const Text(
              'Your Destination',
              style: TextStyle(
                  color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              '-Arrive Safely-',
              style: TextStyle(
                  color: Colors.white, fontSize: 20),
            ),

          ],
        ),
      ),
    );
  }


  // checkId()async{
  //   if(LoginCubit.currentUser.id != ''|| LoginCubit.currentUser.id != null){
  //     User? user = await MyDataBase.readUser(LoginCubit.currentUser.id ?? '');
  //     LoginCubit.currentUser = user!;
  //   }
  //   return;
  // }
}
