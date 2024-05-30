import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/enums/toast_enum.dart';

const String arCode = 'ar';
const String enCode = 'en';

void showToast({required String? meg, required ToastStates toastState}) async {
  await Fluttertoast.showToast(
      msg: meg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:
          toastState == ToastStates.error ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
