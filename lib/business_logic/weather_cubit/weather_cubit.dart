import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/business_logic/weather_cubit/weather_states.dart';
import 'package:weather_app/constants/end_points.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/models/weather_search_model.dart';
import 'package:weather_app/data/shared/remote/dio_helper.dart';

class WeatherCubit extends Cubit<WeatherStates>{

  WeatherCubit() : super(InitialState());

  static WeatherCubit get(context)=> BlocProvider.of(context);


  WeatherModel ?weatherModel;
  WeatherSearchModel ?weatherSearchModel;



  // Get Weather Data
  Future getWeatherData({
    required String city
   }) async{
    emit(GetWeatherDataLoadingState());

    DioHelper.getDate(
        url:WEATHER_DATA,
        query: {
          'key':'da2d14c8dda54695a9a204609220409',
          'q':'$city',
          'days':'12',
          'aqi':'yes',
          'alerts':'yes',
        }
    ).then((value) {

      weatherModel= WeatherModel.fromJson(value.data);
      debugPrint(weatherModel!.location!.country);
      emit(GetWeatherDataSuccessState());
    }).catchError((error){
      debugPrint('Error in get weather : ${error.toString()}');
      emit(GetWeatherDataErrorState());
    });


  }


  // Search about city

  Future getWeatherSearchData({
    required String city
  }) async{

    weatherSearchModel=null;
    emit(GetWeatherDataSearchLoadingState());

    DioHelper.getDate(
        url:WEATHER_DATA,
        query: {
          'key':'da2d14c8dda54695a9a204609220409',
          'q':'$city',
          'days':'12',
          'aqi':'yes',
          'alerts':'yes',
        }
    ).then((value) {
      debugPrint('/////////////////////////////////////////');
      debugPrint('Get Data Success');
      weatherSearchModel= WeatherSearchModel.fromJson(value.data);
      debugPrint('/////////////////////////////////////////');
      emit(GetWeatherSearchDataSuccessState());
    }).catchError((error){
      debugPrint('Error in get weather : ${error.toString()}');
      emit(GetWeatherDataSearchErrorState());
    });

  }


  String ?image='';

  String selectWeatherImage(String description){

    if(description=='Sunny'){
      image='https://assets4.lottiefiles.com/packages/lf20_i7ixqfgx.json';
    }
    else if(description=='Clear'){
      image='https://assets7.lottiefiles.com/temp/lf20_y6mY2A.json';
    }
    else if(description=='Partly cloudy'){
      image='https://assets7.lottiefiles.com/packages/lf20_7TJBhihA6C.json';
    }
    else if(description=='Thundery outbreaks possible'){
      image='https://assets3.lottiefiles.com/private_files/lf30_22gtsfnq.json';
    }
    else if(description=='Patchy light drizzle' || description=='Light drizzle' || description=='Light rain shower' || description=='Light rain'){
      image='https://assets9.lottiefiles.com/private_files/lf30_rb778uhf.json';
    }
    else if(description=='Patchy rain possible' || description=='Moderate rain' || description=='Moderate or heavy rain shower' || description=='Moderate rain at times' || description=='Heavy rain'){
      image='https://assets9.lottiefiles.com/private_files/lf30_jr9yjlcf.json';
    }
    else{
      image='https://assets7.lottiefiles.com/temp/lf20_y6mY2A.json';
    }

    return image!;
    emit(SelectWeatherImageState());

  }

  bool isFavorite=false;

  void changeFavoriteIconColor(){
    isFavorite=!isFavorite;
    emit(ChangeFavoriteIconColorState());
  }


  // Sql Database

  Database ?database;
  List <Map> allCities=[];
  List <Map> favorites=[];


  void createDatabase() async {

    return await openDatabase(
        'city.db',
        version: 1,
        onCreate: (database,version){
          database.execute(
              'CREATE TABLE city (id INTEGER PRIMARY KEY , name TEXT , favorite TEXT)'
          ).then((value) {
            print('Table Created');
            emit(CreateTableState());
          });
        },
        onOpen: (database){
          getDatabase(database).then((value){
            value.forEach((element){

              allCities.add(element);


              if(element['favorite']=='yes')
              {
                favorites.add(element);
              }

            });

          }).catchError((error){
            print('error i ${error.toString()}');
          });
          print('Database Opened');
        }

    ).then((value) {
      database=value;
      print('Database Created');
      emit(CreateDatabaseSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });
  }

  Future insertDatabase(
      {
        required String name,

      }) async{

    return database?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO city (name,favorite) VALUES ( "${name}" , "no" )'
      ).then((value) {
        print("${value} Insert Success");
        emit(InsertDatabaseSuccessState());
        getDatabase(database).then((value){
            value.forEach((element){

              allCities.add(element);


              if(element['favorite']=='yes')
              {
                favorites.add(element);
              }

            });
        });
        emit(InsertDatabaseSuccessState());

      }).catchError((error){
        print('Error is ${error.toString()}');
      });

    });

  }

  Future <List<Map>> getDatabase(database)async {

     allCities=[];
     favorites=[];
     return await database.rawQuery('SELECT * FROM city');
  }


  void updateDatabase(
      {
        required String F,
        required String name,
      }
      ) async{

    database?.rawUpdate(

        'UPDATE city SET favorite = ? WHERE name = ?',
        ['$F', '$name']).then((value) {
      print('Update Done');
      getDatabase(database);
      emit(UpdateFavoriteSuccessState());
    }).catchError((error){
      print('error is ${error.toString()}');
    });

  }



  List <String> topCitiesLocal=[
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Suez',
    'Al-Mansura',
    'Zagazig',
    'Marsa Matruh'
  ];

  List <String> topCitiesWorld=[
    'New York',
    'Paris',
    'London',
    'Tokyo',
    'Rome',
    'Dubai',
    'Moscow',
    'Sydney',
    'Singapore',
    'Beijing',
    'Athens'
  ];











}