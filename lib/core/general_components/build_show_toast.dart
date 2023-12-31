import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/core/general_components/ColorHelper.dart';

Future<bool?> buildShowToast(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: ColorHelper.mainColor,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}