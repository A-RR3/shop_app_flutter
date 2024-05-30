import 'package:easy_localization/easy_localization.dart' as localize;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/modules/layout/cubit/cubit.dart';
import 'package:shop_app_flutter/modules/layout/cubit/states.dart';
import 'package:shop_app_flutter/modules/search/search_screen.dart';

import '../../core/values/lang_keys.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
              appBar: AppBar(
                title: Text(LangKeys.SHOP.tr()),
                actions: [
                  IconButton(
                      onPressed: () {
                        NavigationServices.navigateTo(
                            context, const SearchScreen());
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: cubit.items,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              )),
        );
      },
      listener: (context, state) {},
    );
  }
}
