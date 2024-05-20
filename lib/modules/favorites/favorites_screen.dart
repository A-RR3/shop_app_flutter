import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

          return shopCubit.userFavorites == null ||
                  shopCubit.userFavorites!.data!.data!.isEmpty
              ? const Text('you don\'t have favorites right now')
              : ListView.separated(
                  itemBuilder: (context, index) => FavoriteItem(
                      product: shopCubit.products![index].product,
                      favorites: shopCubit.favorites),
                  separatorBuilder: (context, index) => Constants.myDivider,
                  itemCount: shopCubit.products!.length,
                );
        });
  }
}
