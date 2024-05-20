abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopGetHomeDataLoadingState extends ShopStates {}

class ShopGetHomeDataSuccessState extends ShopStates {}

class ShopGetHomeDataErrorState extends ShopStates {}

class ShopGetCategoriesDataLoadingState extends ShopStates {}

class ShopGetCategoriesDataSuccessState extends ShopStates {}

class ShopGetCategoriesDataErrorState extends ShopStates {}

class ShopGetFavoritesDataLoadingState extends ShopStates {}

class ShopGetFavoritesDataSuccessState extends ShopStates {}

class ShopGetFavoritesDataErrorState extends ShopStates {
  final String? error;
  ShopGetFavoritesDataErrorState(this.error);
}

class ShopChangeFavoritesLoadingState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final String message;
  ShopChangeFavoritesSuccessState(this.message);
}

class ShopChangeFavoritesErrorState extends ShopStates {
  final String error;
  ShopChangeFavoritesErrorState(this.error);
}

class ShopGetProfileDataLoadingState extends ShopStates {}

class ShopGetProfileDataSuccessState extends ShopStates {}

class ShopGetProfileDataErrorState extends ShopStates {}

class ShopUpdateProfileDataLoadingState extends ShopStates {}

class ShopUpdateProfileDataSuccessState extends ShopStates {}

class ShopUpdateProfileDataErrorState extends ShopStates {}
