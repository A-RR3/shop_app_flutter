import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/values/lang_keys.dart';
import '../../shared/constants.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import 'favorite_item_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit shopCubit = ShopCubit.get(context);
          if (state is ShopChangeFavoritesLoadingState ||
              state is ShopGetFavoritesDataLoadingState) {
            return const LinearProgressIndicator();
          } else {
            return shopCubit.userFavorites == null ||
                    shopCubit.userFavorites!.data!.data!.isEmpty
                ? Center(child: Text(LangKeys.YOU_DONT_HAVE_FAVORITES.tr()))
                : ListView.separated(
                    itemBuilder: (context, index) => FavoriteItem(
                        product: shopCubit.products![index].product,
                        favorites: shopCubit.favorites),
                    separatorBuilder: (context, index) => Constants.myDivider,
                    itemCount: shopCubit.products!.length,
                  );
          }
        });
  }
}
