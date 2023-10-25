import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/Auth/Login/View/Pages/login_screen.dart';
import 'package:graduation_project/features/Auth/Register/View/Pages/register_screen.dart';
import 'package:graduation_project/features/splash/View/Pages/splash_screen.dart';

import 'core/general_components/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData(context),
        initialRoute:SplashScreen.routeName,
        routes: {
          SplashScreen.routeName : (_) => SplashScreen(),
          RegisterScreen.routeName : (_) => RegisterScreen(),
          LoginScreen.routeName : (_) => LoginScreen(),
        },
      ),
    );
  }
}
