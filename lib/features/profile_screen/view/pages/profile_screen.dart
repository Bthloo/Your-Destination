import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/profile_screen/view/pages/trip_details_screen.dart';
import 'package:graduation_project/features/profile_screen/viewmodel/history_viewmodel/history_cubit.dart';

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
        actions: [
          IconButton(
              onPressed: (){
                LoginCubit().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        iconTheme: const IconThemeData(color: ColorHelper.mainColor),
        centerTitle: true,
        backgroundColor: ColorHelper.darkColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: ColorHelper.mainColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xff2C3333),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff2C3333)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(LoginCubit.currentUser?.name ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff2C3333)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(LoginCubit.currentUser?.phoneNumber ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff2C3333)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(LoginCubit.currentUser?.email ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              SizedBox(
                height: 20.h,
              ),
              const Text('History', style: TextStyle(
                  color: Colors.white,
                  fontSize:25,
                fontWeight: FontWeight.bold,
              )),
              BlocProvider(
                create: (context) => HistoryCubit()..getData(),
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    if (state is HistoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HistoryError) {
                      return Center(child: Text('${state.message}'));
                    } else if (state is HistorySuccess) {
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              // RideRequest? rideRequest;
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, TripDetailsScreen.routeName,
                                      arguments: state.request[index].data());
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                    color: const Color(0xff2C3333),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'From : ${state.request[index].data().from}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            'To : ${state.request[index].data().to}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 4.h),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${state.request[index].data().price?.substring(0, 6)} EGP',
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 15.sp,
                                                    )),
                                                WidgetSpan(
                                                    child:
                                                        SizedBox(width: 8.w)),
                                                TextSpan(
                                                    text:
                                                        '${state.request[index].data().distance?.substring(0, 6)} KM',
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${state.request[index].data().type}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${state.request[index].data().state}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                '${state.request[index].data().time?.substring(11, 16)}',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.h,
                                ),
                            itemCount: state.request.length),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
