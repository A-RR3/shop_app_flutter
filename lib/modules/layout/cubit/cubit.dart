import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/categories/categories_screen.dart';
import 'package:shop_app_flutter/modules/favorites/favorites_screen.dart';
import 'package:shop_app_flutter/modules/layout/cubit/states.dart';
import 'package:shop_app_flutter/modules/settings/settings_screen.dart';

import '../../home_page/home_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'categories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'favorites'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'settings'),
  ];

  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}
