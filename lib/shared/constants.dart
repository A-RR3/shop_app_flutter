import 'package:flutter/material.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';

Widget vSpace([double height = 20]) => SizedBox(
      height: height,
    );
Widget hSpace([double width = 20]) => SizedBox(
      width: width,
    );

class Constants {
  static String token = CacheHelper.getData(key: 'token');
  static Widget get myDivider =>
      const Divider(color: Colors.grey, thickness: 2);
}
