import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/domain/models/categories_model.dart';
import 'package:shop_app_flutter/domain/models/change_fav_model.dart';
import 'package:shop_app_flutter/domain/models/favorite_model.dart';
import 'package:shop_app_flutter/modules/categories/categories_screen.dart';
import 'package:shop_app_flutter/modules/favorites/favorites_screen.dart';
import 'package:shop_app_flutter/modules/layout/cubit/states.dart';
import 'package:shop_app_flutter/modules/settings/settings_screen.dart';
import 'package:shop_app_flutter/shared/constants.dart';

import '../../../core/utils/navigation_services.dart';
import '../../../core/values/lang_keys.dart';
import '../../../domain/models/home_model.dart';
import '../../../domain/models/login_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';
import '../../home_page/home_screen.dart';
import '../../login/login_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: LangKeys.HOME.tr()),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps), label: LangKeys.CATEGORIES.tr()),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: LangKeys.FAVORITES.tr()),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: LangKeys.SETTINGS.tr()),
  ];

  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};

  HomeModel? homeModel;

  void signOut(BuildContext context) async {
    currentIndex = 0;
    await CacheHelper.removeData(key: 'token');
    NavigationServices.navigateTo(context, LoginScreen(), removeAll: true);
  }

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token).then((response) {
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
            token: token)
        .then((value) {
      favoriteModel = ChangeFavModel.fromJson(value.data);
      if (!favoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopChangeFavoritesSuccessState(favoriteModel!.message));
    }).catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoritesErrorState(favoriteModel!.message));
    });
  }

  FavoriteModel? userFavorites;
  List<Favorites>? products = [];

  void getFavorites() {
    emit(ShopGetFavoritesDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      userFavorites = FavoriteModel.fromJson(value.data);
      products = userFavorites!.data!.data!;
      emit(ShopGetFavoritesDataSuccessState());
    }).catchError((e) {
      emit(ShopGetFavoritesDataErrorState(userFavorites!.message));
    });
  }

  ProfileModel? profileModel;

  void getProfileData() {
    emit(ShopGetProfileDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      emit(ShopGetProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      emit(ShopGetProfileDataErrorState());
    });
  }

  void updateProfileData({required name, required email, required phone}) {
    emit(ShopUpdateProfileDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);

      emit(ShopUpdateProfileDataSuccessState(profileModel!));
    }).catchError((error) {
      emit(ShopUpdateProfileDataErrorState());
    });
  }
}
