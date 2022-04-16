import 'package:dio/dio.dart';

Future<Response?> fetchData({required String path}) async {
  try {
    Dio dio = new Dio();
    dio.options.connectTimeout = 5000;
    Response<dynamic> response = await dio.get(path);

    return response;
  }catch(e){
    return null;
  }
}