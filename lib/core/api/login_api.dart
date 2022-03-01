import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kubik/core/base_url.dart';

class LoginApi {
  static String loginUrl = 'api/v1/login';
  
  static postLogin({String? username, String? password}) async {
    String url = BaseUrl.baseUrl + loginUrl;

    Dio dio = Dio();

    dio.options.headers['Accept'] = 'application/json';
    Map<String, dynamic> mp = {};

    mp['username'] = username;
    mp['password'] = password;
    
    Response response;

    try {
      response = await dio.post(url, data: mp);
      if (kDebugMode) {
        print(response);
      }
      return response.data;
    } catch (e) {
      // L.error(e.toString());
      return null;
    }
  }
}