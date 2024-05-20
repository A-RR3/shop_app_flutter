import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import 'category_item_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => CategoryItem(
                  dataModel: shopCubit.categories[index],
                ),
            separatorBuilder: (context, index) => Constants.myDivider,
            itemCount: shopCubit.categories.length);
      },
    );
  }
}
