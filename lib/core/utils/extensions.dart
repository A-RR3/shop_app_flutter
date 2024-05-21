import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'enums/toast_enum.dart';

extension BuildContextExtentions on BuildContext {
  ThemeData get _theme => Theme.of(this);

  TextTheme get textTheme => _theme.textTheme;

  ColorScheme get colorScheme => _theme.colorScheme;

  Size get screenSize => MediaQuery.sizeOf(this);
}

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
