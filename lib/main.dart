import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/features/Auth/Login/View/Pages/login_screen.dart';
import 'package:graduation_project/features/Auth/Register/View/Pages/register_screen.dart';
import 'package:graduation_project/features/splash/View/Pages/splash_screen.dart';
import 'package:graduation_project/features/waiting_screen/View/pages/waiting_screen.dart';
import 'package:graduation_project/firebase_options.dart';
import 'core/data_base/models/user.dart';
import 'core/data_base/my_database.dart';
import 'core/general_components/theme_data.dart';
import 'features/Auth/Login/ViewModel/login_cubit.dart';
import 'features/home_screen/view/pages/home_screen.dart';
import 'features/profile_screen/view/pages/profile_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await  const FlutterSecureStorage().read(key: 'token').then((value) async {
    if (value != null) {
      LoginCubit.currentUser.id = value;
      User? user = await MyDataBase.readUser(LoginCubit.currentUser.id ?? '');
           LoginCubit.currentUser = user!;
    }
    debugPrint(LoginCubit.currentUser.id);
  });
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
          WaitingScreen.routeName : (_) => WaitingScreen(),
          SplashScreen.routeName : (_) => SplashScreen(),
          RegisterScreen.routeName : (_) => RegisterScreen(),
          LoginScreen.routeName : (_) => LoginScreen(),
          HomeScreen.routeName : (_) => HomeScreen(),
          ProfileScreen.routeName : (_) => ProfileScreen()
        },
      ),
    );
  }
}
