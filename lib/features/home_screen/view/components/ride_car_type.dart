import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/general_components/ColorHelper.dart';

class RideCarType extends StatelessWidget {
  const RideCarType({
    super.key,
    required this.imgPath,
    required this.title,
    required this.selectedType,
  });
  final String imgPath;
  final String title;
  final String selectedType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (selectedType == title)
              ?  ColorHelper.mainColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r)),
      width: 100.w,
      height: 32.h,
      child: Column(children: [
        SizedBox(
          height: 32.0.h,
          width: 100.w,
          child: Image.asset(
            imgPath,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        )
      ]),
    );
  }
}
