import 'package:dio/dio.dart';

Future<Response> fetchData({required String path}) async {
  Response<dynamic> response = await Dio().get(path);

  return response;
}