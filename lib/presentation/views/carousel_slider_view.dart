import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/presentation/styles/assets_manager.dart';

class CarouselSliderView extends StatelessWidget {

  CarouselSliderView({Key? key,required this.isReverse,required this.autoPlayInterval}) : super(key: key);

  bool ?isReverse;
  int ?autoPlayInterval;


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items:const [
          Image(
            image: AssetImage(AssetsManager.cloud),
            height: 150,
            width: 150,
          ),
          SizedBox(
            width: 30,
          ),
        ],

        options: CarouselOptions(
          height: 120,
          pauseAutoPlayOnManualNavigate: true,
          //pageSnapping: true,
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayInFiniteScroll: true,

          // enableInfiniteScroll: true,
          reverse: isReverse!,
          autoPlay: true,
          // enlargeCenterPage: true,
          autoPlayInterval: Duration(milliseconds: autoPlayInterval!),
          autoPlayAnimationDuration: Duration(milliseconds: autoPlayInterval!),
          autoPlayCurve: Curves.linear,
          scrollDirection: Axis.horizontal,
          //viewportFraction: 1.0
        )
    );
  }
}
