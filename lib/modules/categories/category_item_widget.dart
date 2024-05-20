import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/shared/constants.dart';

import '../../domain/models/categories_model.dart';

class CategoryItem extends StatelessWidget {
  DataModel dataModel;
  CategoryItem({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            height: 130,
            width: 130,
          ),
          hSpace(6),
          Text(dataModel.name, style: context.textTheme.labelSmall),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
