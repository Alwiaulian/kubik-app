import 'package:dio/dio.dart';
import 'package:kubik/core/base_url.dart';
import 'package:kubik/core/flutter_no_sql.dart';

class LogoutApi{
  static String logoutUrl = 'api/v1/logout';

  static postLogout() async {
    String url = BaseUrl.baseUrl + logoutUrl;

    Dio dio = Dio();

    String? token = FlutterNoSql.getToken();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    Map<String, dynamic> mp = {};
    Response response;

    try {
      response = await dio.post(url, data: mp);
      return response.data;
    } catch (e) {
      // L.error(e.toString());
      return null;
    }
  }
}