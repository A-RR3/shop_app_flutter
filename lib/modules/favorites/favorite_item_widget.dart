import 'package:flutter/material.dart';
import 'package:shop_app_flutter/domain/models/product_model.dart';

import '../../shared/constants.dart';
import '../layout/cubit/cubit.dart';

class FavoriteItem extends StatelessWidget {
  final ProductModel product;
  final Map<int, bool> favorites;
  final bool search;

  const FavoriteItem(
      {super.key,
      required this.product,
      required this.favorites,
      this.search = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage(product.image),
                  height: 180,
                  width: 180,
                ),
                if (product.discount != 0 && !search)
                  Container(
                    color: Colors.red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Text(
                      'Discount',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6, right: 6, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          product.price.toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Constants.hSpace(10),
                        if (product.discount != 0 && !search)
                          Text(
                            product.oldPrice.toString(),
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        if (!search)
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorite(product.id);
                              },
                              icon: favorites[product.id] == true
                                  ? const Icon(
                                      Icons.favorite,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      size: 30,
                                    )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
