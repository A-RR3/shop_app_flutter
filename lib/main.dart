import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/localization/localization_settings.dart';
import 'package:shop_app_flutter/core/values/local_storage_keys.dart';
import 'package:shop_app_flutter/modules/layout/cubit/cubit.dart';
import 'package:shop_app_flutter/modules/layout/shop_layout.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/modules/on_boarding_screen.dart';
import 'package:shop_app_flutter/shared/network/remote/bloc_observer.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';

import 'core/managers/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding =
      CacheHelper.getData(key: LocalStorageKeys.ON_BOARDING) ?? true;
  String? token = CacheHelper.getData(key: LocalStorageKeys.ACCESS_TOKEN);
  Widget startScreen = onBoarding
      ? OnBoardingScreen()
      : token == null
          ? LoginScreen()
          : const ShopScreen();
  runApp(
    EasyLocalization(
      supportedLocales: LocalizationSettings.localesList,
      path: 'assets/lang',
      fallbackLocale: LocalizationSettings.defaultLocale,
      startLocale: LocalizationSettings.defaultLocale,
      child: MyApp(startScreen: startScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  const MyApp({super.key, this.startScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavorites()
          ..getProfileData(),
        child: MaterialApp(
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: startScreen!,
        ));
  }
}
