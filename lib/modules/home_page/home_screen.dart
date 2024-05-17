import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('home page')),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token');
          NavigationServices.navigateTo(context, LoginScreen(),
              removeAll: true);
        },
        child: const Text('SignOut'),
      ),
    );
  }
}
