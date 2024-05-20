import 'package:flutter/material.dart';
import 'package:shop_app_flutter/core/utils/extensions.dart';
import 'package:shop_app_flutter/domain/models/categories_model.dart';

class CategoryItemWidget extends StatelessWidget {
  final DataModel category;

  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(40), bottomRight: Radius.circular(40));
    return Container(
        width: 150,
        decoration:
            BoxDecoration(borderRadius: borderRadius, color: Colors.blueGrey),
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: Image(
                image: NetworkImage(category.image),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
                bottom: 10,
                left: 0,
                width: 120,
                child: Container(
                  height: 30,
                  color: Colors.black12.withOpacity(.5),
                  child: Center(
                    child: Text(
                      category.name,
                      style: context.textTheme.labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ));
  }
}
