import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_cubit.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_states.dart';
import 'package:weather_app/presentation/screens/search_city.dart';
import 'package:weather_app/presentation/screens/search_weather.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';
import 'package:weather_app/presentation/styles/colors_manager.dart';
import 'package:weather_app/presentation/styles/icon_broken.dart';
import 'package:weather_app/presentation/styles/text_style_manager.dart';

class ManageLocation extends StatelessWidget {
  const ManageLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit,WeatherStates>(
       listener: (context,state){

       },
      builder: (context,state){
         return Scaffold(
           backgroundColor: ColorManager.primaryColor,
           appBar: AppBar(
              centerTitle: true,
              title:  Text(
                  'Add city',style: textStyleManger(20, ColorManager.white,fontWeight: FontWeight.w500)
              ),
           ),
           body: Container(
             padding: const EdgeInsets.symmetric(
               horizontal: 15,
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 GestureDetector(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_){
                       return SearchCity();
                     }));
                   },
                   child: Container(
                     margin: const EdgeInsets.symmetric(
                       vertical: 10
                     ),
                     padding: const EdgeInsets.all(15),
                     decoration: BoxDecoration(
                       color: const Color(0xff2f2f2f),
                       borderRadius: BorderRadius.circular(7)
                     ),
                     child: Row(
                       children: [
                         Icon(
                           IconBroken.Search,
                           color: ColorManager.whiteDark,
                           size: 15,
                         ),
                         const SizedBox(width: 5,),
                         Text(
                             'Enter a place name',style: textStyleManger(15, ColorManager.whiteDark)
                         ),
                       ],
                     ),
                   ),
                 ),
                 const SizedBox(height: 10,),
                 Text(
                     'Top Cities',style: textStyleManger(16, ColorManager.white,fontWeight: FontWeight.w500)
                 ),
                 const SizedBox(height: 15,),
                 SizedBox(
                   height:190,
                   child: GridView.count(
                       crossAxisCount: 3,
                       mainAxisSpacing: 5,
                       crossAxisSpacing: 5,
                       childAspectRatio: 1/.35,
                       children: List.generate(WeatherCubit.get(context).topCitiesLocal.length, (index) {
                         return InkWell(
                           onTap: (){

                             WeatherCubit.get(context).insertDatabase(
                                 name:  WeatherCubit.get(context).topCitiesLocal[index],
                             );

                             WeatherCubit.get(context).getWeatherSearchData(city: WeatherCubit.get(context).topCitiesLocal[index]).then((value) {
                               Navigator.push(context, MaterialPageRoute(builder: (_){
                                 return SearchScreen();
                               }));
                             });

                           },
                           child: Container(
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               border: Border.all(
                                 color: ColorManager.grey
                               ),
                               color: ColorManager.primaryColor,
                               borderRadius: BorderRadius.circular(4)
                             ),
                             child:Text(
                                 WeatherCubit.get(context).topCitiesLocal[index],
                                 style: textStyleManger(13, ColorManager.white,),
                                 textAlign: TextAlign.center,
                             ),
                           ),
                         );

                       }),
                   ),
                 ),
                 const SizedBox(height: 5,),
                 Text(
                     'Top Cities - World',style: textStyleManger(16, ColorManager.white,fontWeight: FontWeight.w500)
                 ),
                 const SizedBox(height: 15,),
                 SizedBox(
                   height:190,
                   child: GridView.count(
                     crossAxisCount: 3,
                     mainAxisSpacing: 5,
                     crossAxisSpacing: 5,
                     childAspectRatio: 1/.35,
                     children: List.generate(WeatherCubit.get(context).topCitiesWorld.length, (index) {
                       return InkWell(
                         onTap: (){
                           WeatherCubit.get(context).insertDatabase(
                             name:  WeatherCubit.get(context).topCitiesWorld[index],
                           );
                           WeatherCubit.get(context).getWeatherSearchData(city: WeatherCubit.get(context).topCitiesWorld[index]).then((value) {
                             Navigator.push(context, MaterialPageRoute(builder: (_){
                               return SearchScreen();
                             }));
                           });
                         },
                         child: Container(
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: ColorManager.grey
                               ),
                               color: ColorManager.primaryColor,
                               borderRadius: BorderRadius.circular(4)
                           ),
                           child:Text(
                             WeatherCubit.get(context).topCitiesWorld[index],
                             style: textStyleManger(13, ColorManager.white,),
                             textAlign: TextAlign.center,
                           ),
                         ),
                       );

                     }),
                   ),
                 ),
               ],
             ),
           ),
         );
      },
    );
  }
}
