import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarouselSlider extends CarouselSlider {
  MyCarouselSlider({
    required List<Widget> items,
    required double width, // viewの幅
    required double height, // カルーセルスライダーの高さ
    double viewportFraction = 0.8,
    int initialPage = 0,
    bool enableInfiniteScroll = true,
    bool autoPlay = false,
    Duration autoPlayInterval = const Duration(seconds: 4),
    Duration autoPlayAnimationDuration = const Duration(milliseconds: 800),
    Curve autoPlayCurve = Curves.fastOutSlowIn,
    required void Function(int) onPageChanged,
    CarouselController? carouselController,
    Key? key
  }) : super(key: key,
    items: items,
    options: CarouselOptions(
        aspectRatio: width / height,
        viewportFraction: viewportFraction,
        initialPage: initialPage,
        enableInfiniteScroll: enableInfiniteScroll,
        autoPlay: autoPlay,
        autoPlayInterval: autoPlayInterval,
        autoPlayAnimationDuration: autoPlayAnimationDuration,
        autoPlayCurve: autoPlayCurve,
        onPageChanged: (page, reason) {
          if( reason != CarouselPageChangedReason.controller ) {
            onPageChanged(page);
          }
        }
    ),
    carouselController: carouselController,
  );
}

class MyCarouselController extends InkWell {
  MyCarouselController({required Color color, required void Function() onTap, Key? key}) : super(key: key,
    onTap: onTap,
    child: Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    ),
  );
}
