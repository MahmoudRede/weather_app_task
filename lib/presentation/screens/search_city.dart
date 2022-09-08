import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_cubit.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_states.dart';
import 'package:weather_app/presentation/screens/search_weather.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';
import 'package:weather_app/presentation/styles/colors_manager.dart';
import 'package:weather_app/presentation/styles/icon_broken.dart';
import 'package:weather_app/presentation/styles/text_style_manager.dart';

class SearchCity extends StatelessWidget {
  var searchController=TextEditingController();
  SearchCity({Key? key}) : super(key: key);

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
                'Search',style: textStyleManger(20, ColorManager.white,fontWeight: FontWeight.w500)
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                   TextFormField(
                    style: GoogleFonts.roboto(
                        color: ColorManager.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15
                    ),
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff2f2f2f),
                      prefixIcon: Icon(
                        IconBroken.Search,
                        color: ColorManager.whiteDark,
                        size: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:ColorManager.primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:ColorManager.primaryColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter a place name',
                      hintStyle: GoogleFonts.roboto(
                        color: ColorManager.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15

                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Write uniform cheering';
                      }
                    },
                  ),
                   const SizedBox(height: 15,),
                   GestureDetector(
                     onTap: (){
                       WeatherCubit.get(context).insertDatabase(
                         name: searchController.text,
                       );
                       WeatherCubit.get(context).getWeatherSearchData(city: searchController.text).then((value) {
                         Navigator.push(context, MaterialPageRoute(builder: (_){
                           return SearchScreen();
                         }));
                       });
                     },
                     child: Align(
                       alignment: Alignment.topRight,
                       child: Text(
                        'Search',style: textStyleManger(17, ColorManager.white,fontWeight: FontWeight.w400)
                ),
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
