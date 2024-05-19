import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/modules/layout/cubit/cubit.dart';
import 'package:shop_app_flutter/modules/layout/cubit/states.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
            appBar: AppBar(title: const Text('Shop')),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            )
            // TextButton(
            //   onPressed: signOut(context),
            //   child: Text('SignOut'),
            // ),
            );
      },
      listener: (context, state) {},
    );
  }
}
