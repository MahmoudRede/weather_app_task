import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_cubit.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_states.dart';
import 'package:weather_app/data/shared/local/cash_helper.dart';
import 'package:weather_app/data/shared/remote/dio_helper.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:weather_app/presentation/screens/manage_location.dart';
import 'package:weather_app/presentation/screens/search_city.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';
import 'package:weather_app/presentation/styles/theme_manager.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>WeatherCubit()..createDatabase(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
          listener: (context,state){

          },
          builder:(context,state){
            return MaterialApp(
                theme: getApplicationTheme(),
                debugShowCheckedModeBanner: false,
                home: SplashScreen()
            );
          } ,
      ),

    );
  }
}

