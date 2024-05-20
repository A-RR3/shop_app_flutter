import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/domain/models/FavoriteModel.dart';
import 'package:shop_app_flutter/domain/models/categories_model.dart';
import 'package:shop_app_flutter/domain/models/change_fav_model.dart';
import 'package:shop_app_flutter/modules/categories/categories_screen.dart';
import 'package:shop_app_flutter/modules/favorites/favorites_screen.dart';
import 'package:shop_app_flutter/modules/layout/cubit/states.dart';
import 'package:shop_app_flutter/modules/settings/settings_screen.dart';
import 'package:shop_app_flutter/shared/constants.dart';

import '../../../domain/models/home_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
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

  Map<int, bool> favorites = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: Constants.token).then((response) {
      homeModel = HomeModel.fromJson(response.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites!});
      });
      emit(ShopGetHomeDataSuccessState());
    }).catchError((error) {
      emit(ShopGetHomeDataErrorState());
    });
  }

  CategoriesModel? categoryModel;
  List<DataModel> categories = [];

  void getCategoriesData() {
    emit(ShopGetCategoriesDataLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((response) {
      categoryModel = CategoriesModel.fromJson(response.data);
      categories = categoryModel!.data.data;
      emit(ShopGetCategoriesDataSuccessState());
    }).catchError((error) {
      emit(ShopGetCategoriesDataErrorState());
    });
  }

  ChangeFavModel? favoriteModel;

  void changeFavorite(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesLoadingState());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: Constants.token)
        .then((value) {
      favoriteModel = ChangeFavModel.fromJson(value.data);
      if (value.data['status'] == false) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopChangeFavoritesSuccessState(favoriteModel!.message));
      }
      getFavorites();
      emit(ShopChangeFavoritesSuccessState(favoriteModel!.message));
    }).catchError((e) {
      print(e.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoritesErrorState(favoriteModel!.message));
    });
  }

  FavoriteModel? userFavorites;
  List<Datum>? products = [];

  void getFavorites() {
    emit(ShopGetFavoritesDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: Constants.token).then((value) {
      userFavorites = FavoriteModel.fromJson(value.data);
      products = userFavorites!.data!.data!;
      emit(ShopGetFavoritesDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopGetFavoritesDataErrorState(userFavorites!.message));
    });
  }
}
