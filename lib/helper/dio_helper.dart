import 'package:dio/dio.dart';
class DioHelper
{
  static late Dio dio;
  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.7:8000/api/',
        receiveDataWhenStatusError: true,

      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? query,
    String? token ,
  }) async
  {
    /*dio.options.headers=
    {
      'Authorization':token,
    };*/
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? data,
    Map<String,dynamic>? query,
    String? token ,
  }) async
  {
    /*dio.options.headers=
    {
      'Authorization':token,
    };*/

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}