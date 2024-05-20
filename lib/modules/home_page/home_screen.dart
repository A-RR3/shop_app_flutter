import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/modules/home_page/widgets/carousel_slider_widget.dart';
import 'package:shop_app_flutter/modules/home_page/widgets/category_item_widget.dart';
import 'package:shop_app_flutter/modules/home_page/widgets/home_product_Item_widget.dart';

import '../../core/utils/navigation_services.dart';
import '../../shared/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/widgets/common_text_widget.dart';
import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);

        return (shopCubit.homeModel == null || shopCubit.categoryModel == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CaroaselSlider(homeModel: shopCubit.homeModel),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(text: 'Categories'),
                          vSpace(),
                          SizedBox(
                              height: context.screenSize.height * .17,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      CategoryItemWidget(
                                          category:
                                              shopCubit.categories[index]),
                                  separatorBuilder: (context, index) =>
                                      hSpace(),
                                  itemCount: shopCubit.categories.length))
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[300],
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1 / 1.55,
                        children: List.generate(
                            shopCubit.homeModel!.data.products.length,
                            (index) => HomeProductItem(
                                  productModel:
                                      shopCubit.homeModel!.data.products[index],
                                )),
                      ),
                    ),
                  ],
                ),
              );
      },
      listener: (context, state) {},
    );
  }
}

void signOut(BuildContext cntx) async {
  await CacheHelper.removeData(key: 'token');
  NavigationServices.navigateTo(cntx, LoginScreen(), removeAll: true);
}
