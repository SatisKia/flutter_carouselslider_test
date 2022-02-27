import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  double contentWidth  = 0.0;
  double contentHeight = 0.0;

  int hogeSliderPage = 0;
  Duration hogeAnimationDuration = Duration(milliseconds: 800);
  Curve hogeCurve = Curves.fastOutSlowIn;
  CarouselController hogeCarouselController = CarouselController();
  void onTapHogeSlider(int page){
    debugPrint('${page + 1}ページ目がタップされた');
  }
  void onTapHogeController(int page){
    if( hogeSliderPage != page ) {
      setState(() {
        hogeSliderPage = page;
      });
      hogeCarouselController.animateToPage(
        hogeSliderPage,
        duration: hogeAnimationDuration,
        curve: hogeCurve,
      );
    }
  }
  void onPageChangedHogeSlider(int page){
    setState(() {
      hogeSliderPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    List<Widget> hogeSliderPages = [
      InkWell(
          onTap: () => onTapHogeSlider(0),
          child: Image.asset('assets/test1.jpg', fit: BoxFit.contain)
      ),
      InkWell(
          onTap: () => onTapHogeSlider(1),
          child: Image.asset('assets/test2.jpg', fit: BoxFit.contain)
      ),
      InkWell(
          onTap: () => onTapHogeSlider(2),
          child: Image.asset('assets/test3.jpg', fit: BoxFit.contain)
      ),
    ];

    double hogeViewportFraction = 0.8;
    double hogeSliderHeight = 214 * (contentWidth / 320) * hogeViewportFraction;

    CarouselSlider hogeSlider = MyCarouselSlider(
      items: hogeSliderPages,
      width: contentWidth,
      height: hogeSliderHeight,
      viewportFraction: hogeViewportFraction,
      initialPage: hogeSliderPage,
      enableInfiniteScroll: true,
      autoPlay: false,
      autoPlayInterval: Duration(seconds: 4),
      autoPlayAnimationDuration: hogeAnimationDuration,
      autoPlayCurve: hogeCurve,
      onPageChanged: onPageChangedHogeSlider,
      carouselController: hogeCarouselController,
    );

    Row hogeController = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyCarouselController(
            onTap: () => onTapHogeController(0),
            color: (hogeSliderPage == 0) ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 192, 192, 192)
        ),
        MyCarouselController(
            onTap: () => onTapHogeController(1),
            color: (hogeSliderPage == 1) ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 192, 192, 192)
        ),
        MyCarouselController(
            onTap: () => onTapHogeController(2),
            color: (hogeSliderPage == 2) ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 192, 192, 192)
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 0
        ),
        body: Column( children: [
          hogeSlider,
          hogeController,
        ])
    );
  }
}
