import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../Auth/Login/ViewModel/login_cubit.dart';
import '../../../Auth/Register/View/Pages/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = 'splash';
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(
      //   context,
      //   (LoginCubit.user.id == ''|| LoginCubit.user.id == null)
      //       ?RegisterScreen.routeName
      //       : UserHome.routeName,
      // );
      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterScreen(),), (route) => false);
    });
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
}
