import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_cubit.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/presentation/styles/colors_manager.dart';
import 'package:weather_app/presentation/views/carousel_slider_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static double lat = 0;
  static double long = 0;

  @override
  void initState() {
    super.initState();
    locationService();
  }


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height*.05,
              ),
                 CarouselSliderView(
                   isReverse: false,
                   autoPlayInterval:  1900,
                 ),
                 CarouselSliderView(
                   isReverse: true,
                   autoPlayInterval:  1700,
                 ),
                CarouselSliderView(
                  isReverse: true,
                  autoPlayInterval:  2200,
                ),
                CarouselSliderView(
                  isReverse: false,
                  autoPlayInterval:  1300,
                ),
                CarouselSliderView(
                  isReverse: false,
                  autoPlayInterval:  2000,
                ),

            ],
          ),
        ],
      ),
    );
  }

  Future<void> locationService() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionLocation;
    LocationData locData;

    serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionLocation = await location.hasPermission();
    if(permissionLocation == PermissionStatus.denied) {
      permissionLocation = await location.requestPermission();
      if(permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    locData = await location.getLocation();

    setState(() {
      lat = locData.latitude!;
      long = locData.longitude!;
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomeScreen(lat: lat,lon: long,)));
    });
  }




}