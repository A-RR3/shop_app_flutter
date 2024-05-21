import 'package:flutter/material.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';

String token = CacheHelper.getData(key: 'token');

class Constants {
  static Widget get myDivider =>
      const Divider(color: Colors.grey, thickness: 2);
  static Widget vSpace([double height = 20]) => SizedBox(
        height: height,
      );
  static Widget hSpace([double width = 20]) => SizedBox(
        width: width,
      );
}
