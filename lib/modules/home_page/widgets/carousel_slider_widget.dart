import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_flutter/domain/models/home_model.dart';

class CaroaselSlider extends StatelessWidget {
  const CaroaselSlider({super.key, required this.homeModel});
  final HomeModel? homeModel;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: homeModel!.data.banners.map((element) {
          return Image(
            image: NetworkImage(element.image),
            width: double.infinity,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return const Image(
                image: NetworkImage(
                    'https://student.valuxapps.com/storage/uploads/banners/1689106805161JH.photo_2023-07-11_23-07-43.png'),
                width: double.infinity,
                fit: BoxFit.fill,
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          // height: 400,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 730),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
  }
}
