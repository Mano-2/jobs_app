// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:login_rest_api/models/config.dart';

class HTTPService {
  final dio = Dio();
  final getIt = GetIt.instance;

  String? baseUrl;
  //String? apiKey;

  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    baseUrl = config.baseApiUrl;
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$baseUrl$path';

      print(url);
      Map<String, dynamic> query0 = {};
      if (query != null) {
        query0.addAll(query);
      }
      return await dio.get(url, queryParameters: query0);
    } on DioException catch (e) {
      throw Exception('Unable to preform GET request DioError: $e');
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      String url = '$baseUrl$path';
      print('POST Request URL: $url');

      final response = await dio.post(url, data: data);

      if (response.statusCode == 201) {
        print('POST Request Successful (Status Code: ${response.statusCode})');
        return response;
      } else {
        print('POST Request Failed (Status Code: ${response.statusCode})');
        throw Exception(
            'Failed to perform POST request. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during POST request: $e');
      throw Exception('Unable to perform POST request: $e');
    }
  }
}
