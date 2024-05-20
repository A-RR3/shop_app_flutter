import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/managers/theme_manager.dart';
import 'package:shop_app_flutter/modules/layout/cubit/cubit.dart';
import 'package:shop_app_flutter/modules/layout/shop_layout.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/modules/on_boarding_screen.dart';
import 'package:shop_app_flutter/shared/bloc_observer.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';
import 'package:shop_app_flutter/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? true;
  String? token = CacheHelper.getData(key: 'token');
  Widget startScreen = onBoarding
      ? const OnBoardingScreen()
      : token == null
          ? LoginScreen()
          : const ShopScreen();
  runApp(MyApp(startScreen: startScreen));
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  const MyApp({super.key, this.startScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
        create: (context) => ShopCubit()
          ..getHomeData()
          ..getCategoriesData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: startScreen!,
        ));
  }
}
