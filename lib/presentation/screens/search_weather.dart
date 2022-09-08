import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_cubit.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_states.dart';
import 'package:weather_app/presentation/screens/manage_location.dart';
import 'package:weather_app/presentation/styles/assets_manager.dart';
import 'package:weather_app/presentation/styles/colors_manager.dart';
import 'package:weather_app/presentation/styles/icon_broken.dart';
import 'package:weather_app/presentation/styles/text_style_manager.dart';
import 'package:weather_app/presentation/widgets/toast.dart';

class SearchScreen extends StatefulWidget {


  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SearchScreen> {

  final bool pinned = true;
  final bool snap = false;
  final bool floating = false;
  String city = '';
  String ?temp;
  String ?weatherText;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // getLocation().then((value) {
    //   WeatherCubit.get(context).getWeatherSearchData(city: city );
    // });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=WeatherCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.primaryColor,
            appBar: AppBar(

            ),

            drawer: Drawer(
              backgroundColor: ColorManager.primaryColor,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: (){},
                          icon: Icon(
                            IconBroken.Setting,
                            size: 25,
                            color: ColorManager.white,
                          )
                      ),
                    ),

                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          IconBroken.Location,
                          size: 25,
                          color: ColorManager.white,
                        ),
                        const SizedBox(width: 10,),
                        Text(
                            'Other locations',style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w400)
                        ),
                      ],
                    ),

                    Container(
                      height: 120,
                      child: ListView.separated(
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                WeatherCubit.get(context).getWeatherSearchData(city:  cubit.allCities[index]['name']).then((value) {
                                  Navigator.push(context, MaterialPageRoute(builder: (_){
                                    return SearchScreen();
                                  }));
                                });
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 30,),
                                  Text(
                                      cubit.allCities[index]['name'],style: textStyleManger(20, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),

                                ],
                              ),
                            );

                          },
                          separatorBuilder: (context,index){

                            return const SizedBox(height: 15,);

                          },
                          itemCount: cubit.allCities.length
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 65,
                            vertical: 15
                        ),
                        color: ColorManager.gold,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            return ManageLocation();
                          }));
                        },
                        child: Text('Manage locations',style: textStyleManger(16, ColorManager.white,fontWeight: FontWeight.w500),),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Divider(
                      thickness: 1,
                      color: ColorManager.white,
                    ),
                    const SizedBox(height: 15,),
                    GestureDetector(
                      onTap: (){
                        customToast(title: 'Will add soon', color: ColorManager.gold);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IconBroken.Info_Circle,
                            size: 25,
                            color: ColorManager.white,
                          ),
                          const SizedBox(width: 10,),

                          Text(
                              'Report wrong location',style: textStyleManger(18, ColorManager.white,fontWeight: FontWeight.w500)
                          ),


                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    GestureDetector(
                      onTap: (){
                        launch('tel:+201277556432');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            IconBroken.Call,
                            size: 25,
                            color: ColorManager.white,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                              'Contact us',style: textStyleManger(18, ColorManager.white,fontWeight: FontWeight.w500)
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            body: cubit.weatherSearchModel!=null?  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              Text(
                                  '${cubit.weatherSearchModel!.current!.tempC}'+'\u00B0',style: textStyleManger(60, Colors.white)
                              ),
                              const Spacer(),
                              Lottie.network(
                                  height: 100,
                                  width: 100,
                                  cubit.selectWeatherImage('${WeatherCubit.get(context).weatherSearchModel!.forecast!.forecastday![0].day!.condition!.text}')
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35
                          ),
                          child: Row(
                            children: [
                              const SizedBox(height: 50,),
                              Text(
                                  '${cubit.weatherSearchModel!.location!.name}',
                                  style: textStyleManger(30, Colors.white)
                              ),
                              IconButton(
                                  onPressed: (){

                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  )
                              ),
                              const Spacer(),

                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Row(
                                children: [
                                  Text(
                                      '${cubit.weatherSearchModel!.forecast!.forecastday![0].day!.maxtempC}\u00B0',
                                      style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),
                                  Text(
                                      '/',
                                      style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),
                                  Text(
                                      '${cubit.weatherSearchModel!.forecast!.forecastday![0].day!.mintempC}\u00B0',
                                      style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),
                                  Text(
                                      ' Feels like ${cubit.weatherSearchModel!.current!.feelslikeC}\u00B0',
                                      style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Row(
                                children: [
                                  Text(
                                      DateFormat('EE, HH:mm').format(DateTime.now()),
                                      style: textStyleManger(15, ColorManager.white,fontWeight: FontWeight.w500)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [

                            const SizedBox(height: 15,),
                            Container(
                                height: 170,
                                width: double.infinity,
                                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                                decoration: BoxDecoration(
                                    color: Color(0xff494949),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 10
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                                '$index:00',
                                                style: textStyleManger(13, ColorManager.white,fontWeight: FontWeight.w500)
                                            ),
                                            const SizedBox(height: 5,),
                                            Lottie.network(
                                                height: 20,
                                                width: 20,
                                                cubit.selectWeatherImage('${cubit.weatherSearchModel!.forecast!.forecastday![0].hour![index].condition!.text}')
                                            ),
                                            const SizedBox(height: 5,),
                                            Text(
                                                '${cubit.weatherSearchModel!.forecast!.forecastday![0].hour![index].tempC}',
                                                style: textStyleManger(13, ColorManager.white,fontWeight: FontWeight.w500)
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                const Image(
                                                  height: 20,
                                                  width: 20,
                                                  image: AssetImage(AssetsManager.rainIcon),
                                                ),
                                                const SizedBox(width: 2,),
                                                Text(
                                                    '${cubit.weatherSearchModel!.forecast!.forecastday![0].hour![index].chanceOfRain}',
                                                    style: textStyleManger(13, ColorManager.white,fontWeight: FontWeight.w500)
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context,index){
                                      return const SizedBox(width: 5,);
                                    },
                                    itemCount: 24
                                )
                            ),
                            Container(
                              height: 100,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 0
                              ),
                              decoration: BoxDecoration(
                                  color:Color(0xff494949),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Tomorrow\'s Temperature',
                                      style: textStyleManger(17, ColorManager.gold,fontWeight: FontWeight.w500)
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                      'Almost the same as today',
                                      style: textStyleManger(17, ColorManager.whiteDark,)
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              height: 270,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              decoration: BoxDecoration(
                                  color: Color(0xff494949),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: ListView.separated(
                                  itemBuilder: (context,index){
                                    return Stack(
                                      alignment: AlignmentDirectional.centerEnd,
                                      children: [
                                        Positioned(
                                          left: 10,
                                          child: Text(
                                              DateFormat('EEEE').format(DateTime.parse((cubit.weatherSearchModel!.forecast!.forecastday![index].date)!)),
                                              style: textStyleManger(
                                                  14, ColorManager.white, fontWeight: FontWeight.w500
                                              )
                                          ),
                                        ),
                                        const Positioned(
                                          left: 95,
                                          child: Image(
                                            height: 15,
                                            width: 15,
                                            image: AssetImage(AssetsManager.rainIcon),
                                          ),
                                        ),
                                        Positioned(
                                          left: 110,
                                          child: Text(
                                              '${cubit.weatherSearchModel!.forecast!.forecastday![index].day!.dailyChanceOfRain}%',
                                              style: textStyleManger(14, ColorManager.whiteDark,)
                                          ),
                                        ),
                                        Text(
                                            '${cubit.weatherSearchModel!.forecast!.forecastday![index].day!.mintempC}\u00B0',
                                            style: textStyleManger(15, ColorManager.white,fontWeight: FontWeight.w500,)
                                        ),

                                        Positioned(
                                          left: 140,
                                          child: Lottie.network(
                                              height: 30,
                                              width: 30,
                                              'https://assets4.lottiefiles.com/packages/lf20_i7ixqfgx.json'
                                          ),
                                        ),
                                        Positioned(
                                          right: 40,
                                          child: Text(
                                              '${cubit.weatherSearchModel!.forecast!.forecastday![index].day!.maxtempC}\u00B0',
                                              style: textStyleManger(15, ColorManager.white,fontWeight: FontWeight.w500,)
                                          ),
                                        ),
                                        Positioned(
                                          right: 90,
                                          child: Lottie.network(
                                              height: 25,
                                              width: 25,
                                              'https://assets7.lottiefiles.com/temp/lf20_y6mY2A.json'
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context,index){
                                    return const SizedBox(height: 10,);
                                  },
                                  itemCount: 12
                              ),
                            ),
                            Container(
                                height: 160,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 0
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff494949),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Sunrise',
                                            style: textStyleManger(17, ColorManager.gold,fontWeight: FontWeight.w500)
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            '${cubit.weatherSearchModel!.forecast!.forecastday![0].astro!.sunrise}',
                                            style: textStyleManger(15, ColorManager.white,fontWeight: FontWeight.w500)
                                        ),
                                        Lottie.network(
                                            'https://assets9.lottiefiles.com/packages/lf20_84jxyn2u.json',
                                            height: 90,
                                            width: 90
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 40,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Sunset',
                                            style: textStyleManger(17, ColorManager.gold,fontWeight: FontWeight.w500)
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            '${cubit.weatherSearchModel!.forecast!.forecastday![0].astro!.sunset}',
                                            style: textStyleManger(15, ColorManager.white,fontWeight: FontWeight.w500)
                                        ),
                                        Lottie.network(
                                            'https://assets7.lottiefiles.com/packages/lf20_5opuln2d.json',
                                            height: 90,
                                            width: 90
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            const SizedBox(height: 10,),
                            Container(
                                height: 160,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 0
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xff494949),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(AssetsManager.uvIcon),
                                          height: 45,
                                          width: 45,
                                        ),
                                        const SizedBox(height: 5,),

                                        Text(
                                            'UV Index',
                                            style: textStyleManger(18, ColorManager.white,fontWeight: FontWeight.w500)
                                        ),
                                        const SizedBox(height: 5,),
                                        if(cubit.weatherSearchModel!.current!.uv ==1 || cubit.weatherSearchModel!.current!.uv ==2)
                                          Text(
                                              'Low',
                                              style: textStyleManger(18, ColorManager.whiteDark,)
                                          ),
                                        if(cubit.weatherSearchModel!.current!.uv ==3 || cubit.weatherSearchModel!.current!.uv ==4 || cubit.weatherSearchModel!.current!.uv ==5 )
                                          Text(
                                              'Moderate',
                                              style: textStyleManger(18, ColorManager.whiteDark,)
                                          ),
                                        if(cubit.weatherSearchModel!.current!.uv ==6 || cubit.weatherSearchModel!.current!.uv ==7 )
                                          Text(
                                              'High',
                                              style: textStyleManger(18, ColorManager.whiteDark,)
                                          ),
                                        if(cubit.weatherSearchModel!.current!.uv ==8 || cubit.weatherSearchModel!.current!.uv ==9 || cubit.weatherSearchModel!.current!.uv ==10)
                                          Text(
                                              'Very High',
                                              style: textStyleManger(18, ColorManager.whiteDark,)
                                          ),
                                        if(cubit.weatherSearchModel!.current!.uv ==11 )
                                          Text(
                                              'Extreme',
                                              style: textStyleManger(18, ColorManager.whiteDark,)
                                          ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      color: ColorManager.whiteDark,
                                      height: 120,
                                      width: 1,
                                    ),
                                    const SizedBox(width: 15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(AssetsManager.windIcon),
                                          height: 45,
                                          width: 45,
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            'Wind',
                                            style: textStyleManger(18, ColorManager.white,fontWeight: FontWeight.w500)
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            '${cubit.weatherSearchModel!.current!.windKph} km/h',
                                            style: textStyleManger(15, ColorManager.whiteDark,)
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      color: ColorManager.whiteDark,
                                      height: 120,
                                      width: 1,
                                    ),
                                    const SizedBox(width: 15,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(AssetsManager.humidityIcon),
                                          height: 45,
                                          width: 45,
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            'Humidity',
                                            style: textStyleManger(18, ColorManager.white,fontWeight: FontWeight.w500)
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                            '${cubit.weatherSearchModel!.current!.humidity} %',
                                            style: textStyleManger(18, ColorManager.whiteDark,)
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                            ),



                          ],
                        ),
                      ],
                    ),

            ):const Center(
              child: CircularProgressIndicator(),
            )
        );
      },


    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
