import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/core/utils/navigation_services.dart';
import 'package:shop_app_flutter/core/values/assets_keys.dart';
import 'package:shop_app_flutter/core/values/lang_keys.dart';
import 'package:shop_app_flutter/domain/models/on_boarding_model.dart';
import 'package:shop_app_flutter/modules/login/login_screen.dart';
import 'package:shop_app_flutter/shared/network/local/cache_helper.dart';
import 'package:shop_app_flutter/shared/widgets/Boarding_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/presentation/Palette.dart';
import '../shared/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});
  bool isLast = false;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = PageController();
    List<OnBoardingModel> boardings = [
      OnBoardingModel(
          image: AssetsKeys.ON_BOARDING_IMG,
          title: LangKeys.TITLE_1,
          body: LangKeys.CONTENT),
      OnBoardingModel(
          image: AssetsKeys.ON_BOARDING_IMG,
          title: LangKeys.TITLE_2,
          body: LangKeys.CONTENT),
      OnBoardingModel(
          image: AssetsKeys.ON_BOARDING_IMG,
          title: LangKeys.TITLE_3,
          body: LangKeys.CONTENT)
    ];

    void submit() {
      CacheHelper.setData(key: 'onBoarding', value: false);
      NavigationServices.navigateTo(context, LoginScreen(), removeAll: true);
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: submit,
                child: Text(
                  LangKeys.SKIP.tr(),
                  style: context.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Palette.primaryColor,
                      fontSize: 18),
                ))
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      BordingItemWidget(boardingItem: boardings[index]),
                  controller: controller,
                  itemCount: 3,
                  onPageChanged: (index) {
                    if (index == boardings.length - 1) {
                      widget.isLast = true;
                    } else {
                      widget.isLast = false;
                    }
                  },
                ),
              ),
              Constants.vSpace(30),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: boardings.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Palette.primaryColor,
                        expansionFactor: 4,
                        spacing: 5,
                        dotHeight: 10,
                        dotWidth: 10),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      (widget.isLast)
                          ? submit()
                          : controller.nextPage(
                              duration: const Duration(milliseconds: 730),
                              curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
