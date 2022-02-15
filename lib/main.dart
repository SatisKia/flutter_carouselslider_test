import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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

  List<String> hogeSliderImageList = [
    'assets/test1.jpg',
    'assets/test2.jpg',
    'assets/test3.jpg',
  ];
  int hogeSliderPage = 0;
  Duration hogeAnimationDuration = Duration(milliseconds: 800);
  Curve hogeCurve = Curves.fastOutSlowIn;
  CarouselController hogeCarouselController = CarouselController();
  void onTapCarouselSlider(int page){
    debugPrint('${page + 1}ページ目がタップされた');
  }

  @override
  Widget build(BuildContext context) {
    contentWidth  = MediaQuery.of( context ).size.width;
    contentHeight = MediaQuery.of( context ).size.height - MediaQuery.of( context ).padding.top - MediaQuery.of( context ).padding.bottom;

    double hogeViewportFraction = 0.8;
    double hogeSliderHeight = 214 * (contentWidth / 320) * hogeViewportFraction;

    CarouselSlider hogeSlider = CarouselSlider(
      items: hogeSliderImageList.map((item) {
        int page = hogeSliderImageList.indexOf(item);
        return InkWell(
            onTap: () {
              if( page == hogeSliderPage ) {
                onTapCarouselSlider(page);
              }
            },
            child: Image.asset(item, fit: BoxFit.contain)
        );
      }).toList(),
      options: CarouselOptions(
          aspectRatio: contentWidth / hogeSliderHeight,
          viewportFraction: hogeViewportFraction,
          initialPage: hogeSliderPage,
          enableInfiniteScroll: true,
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: hogeAnimationDuration,
          autoPlayCurve: hogeCurve,
          onPageChanged: (page, reason) {
            if( reason != CarouselPageChangedReason.controller ) {
              setState(() {
                hogeSliderPage = page;
              });
            }
          }
      ),
      carouselController: hogeCarouselController,
    );

    Row hogeController = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: hogeSliderImageList.map((item) {
        int page = hogeSliderImageList.indexOf(item);
        return InkWell(
            onTap: (){
              setState(() {
                hogeSliderPage = page;
              });
              hogeCarouselController.animateToPage(
                hogeSliderPage,
                duration: hogeAnimationDuration,
                curve: hogeCurve,
              );
            },
            child: Container(
              width: 10,
              height: 10,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (page == hogeSliderPage) ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 192, 192, 192),
              ),
            )
        );
      }).toList(),
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
