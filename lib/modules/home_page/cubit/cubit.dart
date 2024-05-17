import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/modules/categories/categories_screen.dart';
import 'package:shop_app_flutter/modules/favorites/favorites_screen.dart';
import 'package:shop_app_flutter/modules/home_page/cubit/states.dart';
import 'package:shop_app_flutter/modules/home_page/home_screen.dart';
import 'package:shop_app_flutter/modules/settings/settings_screen.dart';

class HomeScreenCubit extends Cubit<ShopStates> {
  HomeScreenCubit() : super(ShopInitialState());

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
    const HomePage(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen()
  ];

  void changeBottomNavBar(int index) async {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}
