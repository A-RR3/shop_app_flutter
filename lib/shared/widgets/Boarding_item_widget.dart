import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/domain/models/on_boarding_model.dart';

import '../../core/values/assets_keys.dart';

class BordingItemWidget extends StatelessWidget {
  final OnBoardingModel boardingItem;
  const BordingItemWidget({super.key, required this.boardingItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:
              Image.asset(AssetsKeys.getImagePath(AssetsKeys.ON_BOARDING_IMG)),
        ),
        Text(
          boardingItem.title.tr(),
          style: context.textTheme.displayMedium,
        ),
        Text(
          boardingItem.body.tr(),
          style: context.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
