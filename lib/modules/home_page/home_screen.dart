import 'package:flutter/material.dart';

import '../../core/utils/navigation_services.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () => signOut(context),
        child: const Text('SignOut'),
      ),
    );
    // return BlocConsumer<ShopCubit, ShopStates>(
    //   builder: (context, state) {
    //     var cubit = ShopCubit.get(context);
    //     return Scaffold(
    //       body: TextButton(
    //         onPressed: signOut(context),
    //         child: Text('SignOut'),
    //       ),
    //     );
    //   },
    //   listener: (context, state) {},
    // );
  }
}

void signOut(BuildContext cntx) async {
  await CacheHelper.removeData(key: 'token');
  NavigationServices.navigateTo(cntx, LoginScreen(), removeAll: true);
}
