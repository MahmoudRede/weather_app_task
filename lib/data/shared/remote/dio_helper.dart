import 'package:dio/dio.dart';

class DioHelper{

  static Dio ?dio;

  static init(){

    dio = Dio(
      BaseOptions(
          baseUrl:'http://api.weatherapi.com/v1/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type':'application/Json'
          }
      ) ,
    );

  }

  static Future<Response> getDate({
    required String url,
    Map <String,dynamic> ?query
  })
  async{

    return await dio!.get(url,queryParameters: query) ;

  }

  static Future<Response> postDate({
    required String url,
    Map <String,dynamic> ?query,
    required Map<String,dynamic> data,
  })
  async{

    return await dio!.post(url,queryParameters: query,data: data) ;

  }



}